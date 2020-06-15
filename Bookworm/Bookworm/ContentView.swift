//
//  ContentView.swift
//  Bookworm
//
//  Created by Boyce Estes on 6/12/20.
//  Copyright © 2020 Boyce Estes. All rights reserved.
//

import SwiftUI

struct BadBookModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .foregroundColor(.red)
            .font(.system(size: 10))
    }
}

extension Text {
    func badBookModifier() -> some View {
        self.modifier(BadBookModifier())
    }
}

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    
    @FetchRequest(entity: Book.entity(), sortDescriptors: []) var books: FetchedResults<Book>
    
    @State private var showScreen = false

    var body: some View {
        NavigationView {
            List {
                ForEach(books, id: \.self) { book in
                    NavigationLink(destination: DetailView(book: book)) {
                        EmojiRatingView(rating: book.rating)
                            .font(.largeTitle)
                        
                        VStack(alignment: .leading) {
                            if book.rating == 1 {
                                Text("\(book.title ?? "Unknown Title")")
                                .font(.headline)
                                .foregroundColor(.red)
                            } else {
                                Text("\(book.title ?? "Unknown Title")")
                                     .font(.headline)
                            }
                            
                            Text("\(book.author ?? "Unknown Author")")
                                .font(.subheadline)
                        }
                    }
                }
                .onDelete(perform: deleteBooks)
            }
            .sheet(isPresented: $showScreen, content: {
                // to pass environment variables use the environment modifier
                AddBookView().environment(\.managedObjectContext, self.moc)
            })
            .navigationBarTitle("Books")
            .navigationBarItems(
                leading: EditButton(),
                trailing: Button(action: {
                print("Add View")
                self.showScreen.toggle()
            }) {
                Image(systemName: "plus")
            })
        }
    }
    
    
    func deleteBooks(at offsets: IndexSet) {
        for offset in offsets {
            let book = books[offset]
            moc.delete(book)
        }
        
        try? moc.save()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
