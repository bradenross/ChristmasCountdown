//
//  NewListPage.swift
//  ChristmasCountdown
//
//  Created by Braden Ross on 6/23/24.
//

import SwiftUI

struct NewListPage: View {
    @ObservedObject var listManager: ListManager
    @State var nameError: Bool = false
    @State var name: String = ""
    @State var selectedImage: String = "wreath"
    let imageNames: [String] = ["wreath", "hat", "santa", "reindeer", "candycanes", "present", "lights", "elf", "mitten", "calendar", "tree", "snowflake", "gingerbreadman", "angel", "ornament", "sleigh", "candy", "candle", "mistletoe", "heart", "snowman"]
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack() {
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Image(systemName: "xmark")
                        .fontWeight(.bold)
                }
                Spacer()
                Button(action: {
                    if(name != "" && selectedImage != "") {
                        listManager.addList(name: name, image: selectedImage)
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
            TextField("Name ", text: $name)
                .foregroundStyle(Constants.Colors.text)
                .padding()
                .background {
                    RoundedRectangle(cornerRadius: 15)
                        .fill(.gray.opacity(0.5))
                        .stroke(.red, lineWidth: nameError ? 3 : 0)
                }
            Spacer()
                .frame(height: 25)
            Text("Image")
                .foregroundStyle(.white)
                .fontWeight(.heavy)
            ScrollView() {
                VStack(alignment: .leading, spacing: 25) {
                    LazyVGrid(columns: columns, spacing: 10) {
                        ForEach(imageNames, id: \.self) { name in
                            Image(name)
                                .resizable()
                                .frame(maxWidth: 100, maxHeight: 100)
                                .aspectRatio(contentMode: .fit)
                                .padding()
                                .background {
                                    RoundedRectangle(cornerRadius: 25)
                                        .fill(selectedImage == name ? .white : .gray.opacity(0.5))
                                }
                                .onTapGesture {
                                    selectedImage = name
                                }
                        }
                    }
                }
            }
        }
        .padding()
        .ignoresSafeArea()
    }
}
