//
//  DetailView.swift
//  BookWorm
//
//  Created by Batuhan Akdemir on 23.12.2023.
//

import SwiftData
import SwiftUI

struct DetailView: View {
    
    let book: Book
    
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    @State private var showingDeleteAlert = false
    
    var body: some View {
        ScrollView {
            ZStack(alignment: .bottomTrailing) {
                Image(book.genre)
                    .resizable()
                    .scaledToFit()

                Text(book.genre.uppercased())
                    .font(.caption)
                    .fontWeight(.black)
                    .padding(8)
                    .foregroundStyle(.white)
                    .background(.black.opacity(0.75))
                    .clipShape(.capsule)
                    .offset(x: -5, y: -5)
            }
            
            Label(book.date.formatted(date: .complete , time: .shortened), systemImage: "calendar" )
                .font(.caption)
                .opacity(0.7)
                .padding(.top , 10)
                              
            
            VStack(spacing: 10){
                Text(book.author)
                    .font(.title)
                    .foregroundStyle(.secondary)

             
                if !book.review.isEmpty {
                    Text(book.review)
                        .padding(.horizontal , 20)
                }
                
                RatingView(rating: .constant(book.rating))
                    .font(.largeTitle)
                    .padding(.top , 10)
                    
            }
            .padding(.top , 10)
           

           
        }
        .navigationTitle(book.title)
        .navigationBarTitleDisplayMode(.inline)
        .scrollBounceBehavior(.basedOnSize)
        .alert("Delete book", isPresented: $showingDeleteAlert) {
            Button("Delete", role: .destructive, action: deleteBook)
            Button("Cancel", role: .cancel) { }
        } message: {
            Text("Are you sure?")
        }
        
        .toolbar {
            Button("Delete this book", systemImage: "trash") {
                showingDeleteAlert = true
            }
        }
    }
    
    func deleteBook() {
        modelContext.delete(book)
        dismiss()
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Book.self, configurations: config)
        let example = Book(title: "Test Book", author: "Test Author", genre: "Fantasy", review: "This was a great book; I really enjoyed it.", rating: 4, date: Date())

        return DetailView(book: example)
            .modelContainer(container)
    } catch {
        return Text("Failed to create preview: \(error.localizedDescription)")
    }
}
