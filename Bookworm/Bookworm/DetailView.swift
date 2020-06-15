//
//  DetailView.swift
//  Bookworm
//
//  Created by Boyce Estes on 6/14/20.
//  Copyright © 2020 Boyce Estes. All rights reserved.
//

import SwiftUI
import CoreData

struct DetailView: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var presentationMode
    
    @State private var showingDeleteAlert = false
    
    var book: Book
    let formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter
    }()
    
    var body: some View {
        GeometryReader { geo in
            VStack {
                ZStack {
                    Image(self.book.genre ?? "Fantasy")
                        .frame(maxWidth: geo.size.width)
                        
                    Text(self.book.genre?.uppercased() ?? "FANTASY")
                        .font(.caption)
                        .fontWeight(.black)
                        .padding(8)
                        .foregroundColor(.white)
                        .background(Color.black.opacity(0.75))
                        .clipShape(Capsule())
                        .offset(x: 150, y: 80)
                        
                }
                
                    
                Text(self.book.author ?? "Unknown author")
                    .font(.title)
                    .foregroundColor(.secondary)
                    
                Text(self.book.review ?? "No review")
                        .padding()
                    
                StarRating(rating: .constant(Int(self.book.rating)))
                
                    
                Spacer()
                
                Text(self.formatter.string(from: self.book.date ?? Date()))
            }
        }
        .navigationBarTitle(Text(book.title ?? "Unknown Book"), displayMode: .inline)
        .alert(isPresented: $showingDeleteAlert) {
            Alert(title: Text("Delete book"),
                  message: Text("Are you sure?"),
                  primaryButton: .destructive(Text("Delete")) {
                        self.deleteBook()
                    
                  }, secondaryButton: .cancel())
        }
        .navigationBarItems(trailing: Button(action: {
            self.showingDeleteAlert = true
        }) {
            Image(systemName: "trash")
        })
    }
    
    func deleteBook() {
        moc.delete(book)
        
        // try? self.moc.save()
        //
        
        presentationMode.wrappedValue.dismiss()
    }
}

struct DetailView_Previews: PreviewProvider {
    // import coredata and create temporary moc to create a book example object
    static let moc = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
    
    static var previews: some View {
        let book = Book(context: moc)
        book.title = "Test Book"
        book.author = "Mr. Author"
        book.genre = "Fantasy"
        book.rating = 4
        book.review = "It was stupidenous."
        
        return NavigationView {
            DetailView(book: book)
        }
    }
}
