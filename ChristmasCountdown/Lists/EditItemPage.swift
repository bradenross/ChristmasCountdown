//
//  EditItemPage.swift
//  ChristmasCountdown
//
//  Created by Braden Ross on 6/29/24.
//

import SwiftUI

struct EditItemPage: View {
    @ObservedObject var listManager: ListManager
    var list: ChristmasList
    var item: ChristmasListItem
    @State var name: String
    @State var price: Double = 0.0
    @State var priceInput: String = ""
    @State var url: String
    @State var isPurchased: Bool
    
    @State var isValid: Bool = true
    
    init(list: ChristmasList, item: ChristmasListItem, listManager: ListManager) {
        self.list = list
        self.item = item
        self.name = item.name
        self.price = item.price
        self.priceInput = String(item.price)
        self.isPurchased = item.purchased
        self.url = item.url
        self.listManager = listManager
    }
    
    var body: some View {
        VStack() {
            TextField("Name", text: $name)
                .foregroundStyle(.white)
                .padding()
                .background {
                    RoundedRectangle(cornerRadius: 15)
                        .fill(.gray.opacity(0.5))
                }
            TextField("Price", text: $priceInput)
                .foregroundStyle(.white)
                .padding()
                .background {
                    RoundedRectangle(cornerRadius: 15)
                        .fill(.gray.opacity(0.5))
                }
                .keyboardType(.decimalPad)
                .onChange(of: priceInput) { newValue in
                    if !newValue.isEmpty {
                        if !isValidInput(newValue) {
                            priceInput = String(priceInput.dropLast())
                        } else {
                            if let newValue = Double(newValue) {
                                price = newValue
                            }
                        }
                    } else {
                        price = 0.0
                    }
                    isValid = isValidInput(newValue)
                }
            HStack() {
                TextField("URL", text: $url)
                    .foregroundStyle(.white)
                    .padding()
                    .background {
                        RoundedRectangle(cornerRadius: 15)
                            .fill(.gray.opacity(0.5))
                    }
                Button(action: {
                    UIPasteboard.general.string = self.url
                }) {
                    Text("Copy")
                }
            }
        }
        .padding()
        .onDisappear() {
            listManager.editItem(in: list.id, itemId: item.id, name: name, price: price, purchased: isPurchased)
        }
    }
    
    private func isValidInput(_ input: String) -> Bool {
        let regex = #"^\$?\d*\.?\d{0,2}$"#
        let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
        return predicate.evaluate(with: input)
    }
}

func formatPrice(_ value: String) -> String {
    var formattedValue = ""
    let formatter = NumberFormatter()
    formatter.numberStyle = .currency
    formatter.maximumFractionDigits = 2
    
    if let number = formatter.number(from: value) {
        formattedValue = formatter.string(from: number) ?? ""
    }
    
    return formattedValue
}
