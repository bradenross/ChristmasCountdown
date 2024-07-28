//
//  ListsPage.swift
//  ChristmasCountdown
//
//  Created by Braden Ross on 6/17/24.
//

import SwiftUI

struct ListsPage: View {
    @StateObject private var listManager = ListManager()
    @State private var newListName = ""
    @State private var newListMenuOpen: Bool = false
    
    var body: some View {
        NavigationView() {
            VStack() {
                HStack() {
                    HStack() {
                        Text("Lists")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                        if(listManager.lists.count <= 50) {
                            Image(systemName: "\(listManager.lists.count).circle.fill")
                                .font(.title)
                        }
                    }
                    Spacer()
                    Button(action: {newListMenuOpen = true}) {
                        Image(systemName: "plus")
                            .fontWeight(.bold)
                            .scaleEffect(CGSize(width: 1.5, height: 1.5))
                    }
                }
                .padding(.vertical, 7)
                .padding(.horizontal, 20)
                .background(.clear)
                
                if (listManager.lists.count == 0) {
                    Text("No lists yet...\nHit the '+' button to create one!")
                        .multilineTextAlignment(.center)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else {
                    List {
                        ForEach(listManager.lists) { list in
                            NavigationLink(destination: ItemListPage(listManager: listManager, list: list)) {
                                Section() {
                                    ListPersonItem(listInfo: list)
                                }
                            }
                            
                        }
                        .onDelete(perform: listManager.deleteList)

                    }
                    .listRowSpacing(0)
                }
            }
            .safeAreaPadding(.bottom, Constants.Paddings.safeAreaPaddingBottomTabView)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .sheet(isPresented: $newListMenuOpen) {
                NewListPage(listManager: listManager)
            }
        }
    }
}
