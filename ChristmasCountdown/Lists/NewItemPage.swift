//
//  NewItemPage.swift
//  ChristmasCountdown
//
//  Created by Braden Ross on 6/24/24.
//

import SwiftUI

struct NewItemPage: View {
    var listManager: ListManager
    var list: ChristmasList
    
    @State private var name: String = ""
    @State private var url: String = ""
    @State private var priceInput: String = ""
    @State private var price: Double = 0
    @State private var isPurchased: Bool = false
    
    @State private var isValid = true
    
    @State private var nameError: Bool = false
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack(alignment: .leading, spacing: 25) {
            HStack() {
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Image(systemName: "xmark")
                        .fontWeight(.bold)
                }
                Spacer()
                Button(action: {
                    if(name != "") {
                        listManager.addItem(to: list.id, itemName: name, itemPrice: price, itemPurchased: isPurchased, url: url)
                        presentationMode.wrappedValue.dismiss()
                    } else if(name == "") {
                        nameError = true
                    }
                }) {
                    Text("Save")
                        .fontWeight(.bold)
                }
            }
            .padding(.horizontal)
            .padding(.vertical, 10)
            TextField("Name", text: $name)
                .foregroundStyle(Constants.Colors.text)
                .padding()
                .background {
                    RoundedRectangle(cornerRadius: 15)
                        .fill(.gray.opacity(0.5))
                        .stroke(.red, lineWidth: nameError ? 3 : 0)
                }
            TextField("Price", text: $priceInput)
                .foregroundStyle(Constants.Colors.text)
                .padding()
                .background {
                    RoundedRectangle(cornerRadius: 15)
                        .fill(.gray.opacity(0.5))
                        .stroke(.red, lineWidth: nameError ? 3 : 0)
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
            TextField("url", text: $url)
                .foregroundStyle(Constants.Colors.text)
                .padding()
                .background {
                    RoundedRectangle(cornerRadius: 15)
                        .fill(.gray.opacity(0.5))
                        .stroke(.red, lineWidth: nameError ? 3 : 0)
                }
            HStack() {
                Spacer()
                Button(action: {
                    UIPasteboard.general.string = self.url
                }) {
                    Text("Copy URL")
                        .padding(.vertical, 10)
                }
                Spacer()
                Button(action: {
                    if let copiedText = UIPasteboard.general.string {
                        url = copiedText
                    }
                }) {
                    Text("Paste URL")
                        .padding(.vertical, 10)
                }
                Spacer()
            }
            HStack() {
                Toggle("Already Purchased?", isOn: $isPurchased)
            }
            Spacer()
        }
        .padding()
        .ignoresSafeArea()
    }
    
    private func isValidInput(_ input: String) -> Bool {
        let regex = #"^\$?\d*\.?\d{0,2}$"#
        let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
        return predicate.evaluate(with: input)
    }
}
