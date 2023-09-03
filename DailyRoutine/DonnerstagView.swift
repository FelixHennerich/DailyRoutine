import SwiftUI

struct DonnerstagView: View {
    @State private var items: [Item] = [
        Item(name: "Wakeup xx:xx"),
        Item(name: "Hampelmänner 40x"),
        Item(name: "Bizeps 10kg 7x"),
        Item(name: "Knie auf Bank Trizeps 10kg"),
        Item(name: "Benchpress 40kg 7-10x"),
        Item(name: "Schulter 10kg 7x"),
        Item(name: "Curl 10kg 15x"),
        Item(name: "Dehnen"),
        Item(name: "Schule xx:xx"),
    ]

    @State private var isAddingNewItem = false

    var body: some View {
        NavigationView {
            VStack {

                List {
                    ForEach(items) { item in
                        HStack {
                            Text(item.name).font(.system(size:20, weight: .bold))
                            Spacer()
                            Toggle("", isOn: $items[items.firstIndex(where: { $0.id == item.id })!].isChecked)
                                .toggleStyle(SwitchToggleStyle(tint: Color.green))
                        }
                    }
                    .onDelete(perform: deleteItems)
                }
                .background(Color.white)
                .padding()

                Button(action: {
                    isAddingNewItem = true
                }) {
                    Text("Neue Routine hinzufügen")
                        .font(.headline)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding()
            }
            .navigationTitle("Donnerstag - Routine")
            .navigationBarItems(trailing: EditButton())
        }
        .sheet(isPresented: $isAddingNewItem, content: {
            AddNewItemViewDonnerstagView(items: $items, isPresented: $isAddingNewItem)
        })
    }

    func deleteItems(at offsets: IndexSet) {
        items.remove(atOffsets: offsets)
    }
}

struct DonnerstagView_Previews: PreviewProvider {
    static var previews: some View {
        DonnerstagView()
    }
}

struct AddNewItemViewDonnerstagView: View {
    @Binding var items: [Item]
    @Binding var isPresented: Bool
    @State private var newItemName = ""

    var body: some View {
        NavigationView {
            VStack {
                TextField("Neue Routine eingeben", text: $newItemName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()

                Button(action: {
                    if !newItemName.isEmpty {
                        items.append(Item(name: newItemName))
                        isPresented = false
                    }
                }) {
                    Text("Hinzufügen")
                        .font(.headline)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding()
            }
            .navigationTitle("Neue Routine hinzufügen")
            .navigationBarItems(trailing: Button("Abbrechen") {
                isPresented = false
            })
        }
    }
}
