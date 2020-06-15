//
//  AddBookView.swift
//  Bookworm
//
//  Created by Boyce Estes on 6/13/20.
//  Copyright © 2020 Boyce Estes. All rights reserved.
//

import SwiftUI

struct AddBookView: View {
    
    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var presentationMode
    
    let genres = ["Fantasy", "Horror", "Kids", "Mystery", "Poetry", "Romance", "Thriller"]
    
    @State private var author = ""
    @State private var genre = ""
    @State private var rating = 3
    @State private var review = ""
    @State private var title = ""
    
    @State private var showAlert = false
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("title", text: $title)
                    TextField("author", text: $author)
                }

                
                Section {
                    // Label then binding
                    Picker("Genre", selection: $genre) {
                        ForEach(genres, id: \.self) {
                            Text($0)
                        }
                    }
                }
                
                Section {
//                    Picker("Rating", selection: $rating) {
//                        ForEach(0..<6) {
//                            Text("\($0)")
//
//                        }
//                    }
                    StarRating(rating: $rating)
                    TextField("Review", text: $review)
                }
                
                Section {
                    Button("Save") {
                        print("save")
                        self.saveBook()
                    }
                }
            }
            .navigationBarTitle("Add Book")
            .navigationBarItems(leading: Button("Cancel") {
                print("cancel")
                self.presentationMode.wrappedValue.dismiss()
            })
        }
        .alert(isPresented: $showAlert) { () -> Alert in
            Alert(title: Text("Oops!)"), message: Text("Don't forget to set genre!"), dismissButton: .cancel(Text("OK")))
        }
    }
    
    func saveBook() {
        if genre == "" {
            showAlert = true
        } else {
            let book = Book(context: moc)
             
             book.author = author
             book.genre = genre
             book.rating = Int16(rating)
             book.review = review
             book.title = title
             book.date = Date()
             
             try? moc.save()
             self.presentationMode.wrappedValue.dismiss()
        }
    }
}

struct AddBookView_Previews: PreviewProvider {
    static var previews: some View {
        AddBookView()
    }
}
