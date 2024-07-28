//
//  ListManager.swift
//  ChristmasCountdown
//
//  Created by Braden Ross on 6/23/24.
//

import Foundation

class ListManager: ObservableObject {
    @Published var lists: [ChristmasList] = []
    private let fileName = "ChristmasLists.json"
    
    init() {
        load()
    }
    
    private func load() {
        let url = getDocumentsDirectory().appendingPathComponent(fileName)
        do {
            let data = try Data(contentsOf: url)
            lists = try JSONDecoder().decode([ChristmasList].self, from: data)
        } catch {
            print("Failed to load lists: \(error.localizedDescription)")
        }
    }
    
    private func getDocumentsDirectory() -> URL {
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
    
    func addList(name: String, image: String) {
        let newList = ChristmasList(name: name, image: image, items: [])
        lists.append(newList)
        save()
    }
    
    func editList(id: UUID, name: String, image: String) {
        if let index = lists.firstIndex(where: { $0.id == id }) {
            lists[index].name = name
            lists[index].image = image
            save()
        }
    }
    
    func deleteList(at offsets: IndexSet) {
        lists.remove(atOffsets: offsets)
        save()
    }
    
    func addItem(to listId: UUID, itemName: String, itemPrice: Double, itemPurchased: Bool, url: String) {
        print("ITEM ADDED")
        if let index = lists.firstIndex(where: { $0.id == listId }) {
            let newItem = ChristmasListItem(name: itemName, url: url, price: itemPrice, purchased: itemPurchased)
            lists[index].items.append(newItem)
            save()
        }
    }
    
    func editItem(in listId: UUID, itemId: UUID, name: String, price: Double, purchased: Bool) {
        print("ITEM EDITED \(price)")
        if let listIndex = lists.firstIndex(where: { $0.id == listId }) {
            if let itemIndex = lists[listIndex].items.firstIndex(where: { $0.id == itemId }) {
                lists[listIndex].items[itemIndex].name = name
                lists[listIndex].items[itemIndex].price = price
                lists[listIndex].items[itemIndex].purchased = purchased
                lists[listIndex].cost = lists[listIndex].items.reduce(0.0) { $0 + Double($1.price) }
                save()
            }
        }
    }
    
    func toggleAllItemsPurchased(in listId: UUID) {
        if let listIndex = lists.firstIndex(where: { $0.id == listId }) {
            let allPurchased = lists[listIndex].items.allSatisfy { $0.purchased }
            for index in lists[listIndex].items.indices {
                lists[listIndex].items[index].purchased = !allPurchased
            }
            save()
        }
    }
    
    func deleteItem(from listId: UUID, itemId: UUID) {
        print("ITEM DELETED")
        if let listIndex = lists.firstIndex(where: { $0.id == listId }) {
            if let itemIndex = lists[listIndex].items.firstIndex(where: { $0.id == itemId }) {
                lists[listIndex].items.remove(at: itemIndex)
                save()
            }
        }
    }
    
    func clearItems(from listId: UUID) {
        if let listIndex = lists.firstIndex(where: { $0.id == listId }) {
            lists[listIndex].items.removeAll()
            save()
        }
    }
    
    private func save() {
        print("SAVED ITEM")
        let url = getDocumentsDirectory().appendingPathComponent(fileName)
        do {
            let data = try JSONEncoder().encode(lists)
            try data.write(to: url)
        } catch {
            print("Failed to save lists: \(error.localizedDescription)")
        }
    }
}

struct ChristmasList: Codable, Identifiable {
    var id = UUID()
    var name: String
    var image: String
    var cost: Double = 0
    var items: [ChristmasListItem]
    
    func numberOfItemsBought() -> Int {
        return items.filter { $0.purchased }.count
    }
    
    func calculateTotalCost() -> Double{
        return items.reduce(0.0) { $0 + Double($1.price) }
    }
}

struct ChristmasListItem: Codable, Identifiable, Hashable {
    var id = UUID()
    var name: String = ""
    var url: String = ""
    var price: Double = 0.0
    var purchased: Bool = false
}
