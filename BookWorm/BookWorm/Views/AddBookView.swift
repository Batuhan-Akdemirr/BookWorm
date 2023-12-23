//
//  AddBookView.swift
//  BookWorm
//
//  Created by Batuhan Akdemir on 23.12.2023.
//

import SwiftUI

struct AddBookView: View {
    
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    
    @State private var title = ""
    @State private var author = ""
    @State private var rating = 3
    @State private var genre = Genres.fantasy
    @State private var review = ""
    

    var itemIsEmpty : Bool {
        if title.isEmpty || author.isEmpty || genre.rawValue.isEmpty {
            return false
        }
        
        return true
    }
    
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Name of book", text: $title)
                    TextField("Author's name", text: $author)

                    Picker("Genre", selection: $genre) {
                        ForEach(Genres.allCases, id: \.self) {
                            Text($0.rawValue)
                        }
                    }
                }

                Section("Write a review") {
                    TextEditor(text: $review)

                  RatingView(rating: $rating)
                 
                }

                Section {
                    Button{
                        let newBook = Book(title: title, author: author, genre: genre.rawValue, review: review, rating: rating, date: Date())
                        modelContext.insert(newBook)
                        dismiss()
                    } label: {
                        HStack {
                            Spacer()
                            Text("Save")
                            Spacer()
                            
                        }
                    }
                    .disabled(itemIsEmpty == false)
                }
            }
            .navigationTitle("Add Book")
        }
    }
}

#Preview {
    AddBookView()
}
