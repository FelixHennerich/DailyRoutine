import SwiftUI

struct ContentView: View {
    @State private var items: [Item] = [
        Item(name: "Workout"),
        Item(name: "Duschen"),
        Item(name: "Frühstück"),
        Item(name: "Schule"),
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
                    Text("Neues Element hinzufügen")
                        .font(.headline)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding()
            }
            .navigationTitle("Daily Routine")
            .navigationBarItems(trailing: EditButton())
        }
        .sheet(isPresented: $isAddingNewItem, content: {
            AddNewItemView(items: $items, isPresented: $isAddingNewItem)
        })
    }

    func deleteItems(at offsets: IndexSet) {
        items.remove(atOffsets: offsets)
    }
}

struct Item: Identifiable {
    let id = UUID()
    var name: String
    var isChecked = false
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct AddNewItemView: View {
    @Binding var items: [Item]
    @Binding var isPresented: Bool
    @State private var newItemName = ""

    var body: some View {
        NavigationView {
            VStack {
                TextField("Neues Element eingeben", text: $newItemName)
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
            .navigationTitle("Neues Element hinzufügen")
            .navigationBarItems(trailing: Button("Abbrechen") {
                isPresented = false
            })
        }
    }
}
