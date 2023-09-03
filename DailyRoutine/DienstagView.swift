import SwiftUI

struct DienstagView: View {
    @State private var items: [Item] = [
        Item(name: "Wakeup xx:xx"),
        Item(name: "Hampelmänner 40x"),
        Item(name: "Situps Bank 2,5kg 20x"),
        Item(name: "Crunch 2,5kg 20x"),
        Item(name: "Seitenlehnung 2,5kg 20x"),
        Item(name: "Beinhebung 12x"),
        Item(name: "Crossover Crunch 12x"),
        Item(name: "Situps Bank 5kg 20x"),
        Item(name: "Kobradehnung"),
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
            .navigationTitle("Dienstag - Routine")
            .navigationBarItems(trailing: EditButton())
        }
        .sheet(isPresented: $isAddingNewItem, content: {
            AddNewItemViewDienstagView(items: $items, isPresented: $isAddingNewItem)
        })
    }

    func deleteItems(at offsets: IndexSet) {
        items.remove(atOffsets: offsets)
    }
}

struct DienstagView_Previews: PreviewProvider {
    static var previews: some View {
        DienstagView()
    }
}

struct AddNewItemViewDienstagView: View {
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
