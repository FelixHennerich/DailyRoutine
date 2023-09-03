import SwiftUI

struct SonntagView: View {
    @State private var items: [Item] = [
        Item(name: "Wakeup xx:xx"),
        Item(name: ""),
        Item(name: ""),
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
            .navigationTitle("Sonntag - Routine")
            .navigationBarItems(trailing: EditButton())
        }
        .sheet(isPresented: $isAddingNewItem, content: {
            AddNewItemViewSonntagView(items: $items, isPresented: $isAddingNewItem)
        })
    }

    func deleteItems(at offsets: IndexSet) {
        items.remove(atOffsets: offsets)
    }
}

struct SonntagView_Previews: PreviewProvider {
    static var previews: some View {
        SonntagView()
    }
}

struct AddNewItemViewSonntagView: View {
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
