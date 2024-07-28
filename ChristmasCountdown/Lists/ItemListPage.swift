//
//  ItemListPage.swift
//  ChristmasCountdown
//
//  Created by Braden Ross on 6/24/24.
//

import SwiftUI

struct ItemListPage: View {
    @ObservedObject var listManager: ListManager
    var list: ChristmasList
    
    @State var showClearAlert: Bool = false
    
    @State var newItemPageOpen: Bool = false
    @State var editListPageOpen: Bool = false
    @State var totalCost: Double = 0.0
    
    var body: some View {
        VStack() {
            HStack() {
                VStack() {
                    Text("Total Cost:")
                        .font(.headline)
                        .fontWeight(.bold)
                    Text("\(totalCost, format: .currency(code: "USD"))")
                }
                Spacer()
                CircularProgressView(progress: Double(list.numberOfItemsBought()) / Double(list.items.count))
                    .frame(width: 30, height: 30)
            }
            .padding(.horizontal)
            .padding(.top)
            List {
                ForEach(list.items, id: \.self) { item in
                    NavigationLink(destination: EditItemPage(list: list, item: item, listManager: listManager)) {
                        HStack() {
                            VStack(alignment: .leading) {
                                Text(item.name)
                                    .font(.headline)
                                Text(item.price, format: .currency(code: "USD"))
                                    .font(.caption)
                            }
                            Spacer()
                                .frame(maxWidth: .infinity)
                            if(item.purchased) {
                                Image(systemName: "checkmark.circle")
                                    .frame(width: 50)
                            } else {
                                Spacer()
                                    .frame(width: 50)
                            }
                        }
                    }
                    .swipeActions(edge: .leading) {
                        Button(action: {
                            listManager.editItem(in: list.id, itemId: item.id, name: item.name, price: item.price, purchased: !item.purchased)
                        }) {
                            Image(systemName: item.purchased ? "checkmark.circle.badge.xmark" : "checkmark.circle")
                                .tint(item.purchased ? .red : .green)
                        }
                    }
                }
                .onDelete { indexSet in
                    if let index = indexSet.first {
                        listManager.deleteItem(from: list.id, itemId: list.items[index].id)
                    }
                }
            }
            .toolbar {
                ToolbarTitleMenu {
                    Button("Edit") {
                        editListPageOpen = true
                    }
                    
                    Button("Toggle All Purchased") {
                        listManager.toggleAllItemsPurchased(in: list.id)
                    }
                    
                    Button("Clear", role: .destructive) {
                        showClearAlert = true
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                        newItemPageOpen = true
                    }) {
                        Image(systemName: "plus")
                            .fontWeight(.bold)
                    }
                }
            }
            .sheet(isPresented: $newItemPageOpen) {
                NewItemPage(listManager: listManager, list: list)
            }
            .sheet(isPresented: $editListPageOpen) {
                EditListPage(listManager: listManager, list: list)
            }
            .alert(isPresented: $showClearAlert) {
                Alert(
                    title: Text("Clear All Items"),
                    message: Text("Are you sure you want to delete all items?"),
                    primaryButton: .destructive(Text("Clear")) {
                        listManager.clearItems(from: list.id)
                    },
                    secondaryButton: .cancel()
                )
            }
            .navigationTitle(list.name)
        }
        .safeAreaPadding(.bottom, Constants.Paddings.safeAreaPaddingBottomTabView)
        .onAppear() {
            totalCost = list.calculateTotalCost()
        }
        .onChange(of: list.items) { _ in
            totalCost = list.calculateTotalCost()
        }
    }
}
