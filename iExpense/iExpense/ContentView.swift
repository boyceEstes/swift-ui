//
//  ContentView.swift
//  iExpense
//
//  Created by Boyce Estes on 5/27/20.
//  Copyright © 2020 Boyce Estes. All rights reserved.
//

import SwiftUI

struct ExpenseItem: Identifiable, Codable {
    let id = UUID()
    let name: String
    let type: String
    let amount: Int
}

class Expenses: ObservableObject {
    @Published var items: [ExpenseItem] {
        didSet {
            print("Items was set. Encode \(items.count) items to ")
            // save any updates in UserDefaults
            let encoder = JSONEncoder()
            if let encoded = try? encoder.encode(items) {
                UserDefaults.standard.set(encoded, forKey: "Items")
                print("encoded: \(self.items.count) current items")
            }
        }
    }
    
    init() {
        if let items = UserDefaults.standard.data(forKey: "Items") {
            let decoder = JSONDecoder()
            if let decoded = try? decoder.decode([ExpenseItem].self, from: items) {
                self.items = decoded
                print("decoded: \(self.items.count) current items")
                return
            }
        }
        self.items = []
        print("decoded: \(self.items.count) current items")
    }
}

struct MoneyModifier: ViewModifier {
    var amount: Int
    
    func body(content: Content) -> some View {
        if amount > 999 {
            return VStack(alignment: .trailing) {
                Text("HAHAHAHA")
                    .font(.system(size: 20))
                content
            }
            .foregroundColor(.red)
        } else if amount > 499{
            return VStack(alignment: .trailing) {
                Text("Maybe in a few years.")
                    .font(.system(size: 20))
                content
            }
            .foregroundColor(.orange)
        } else {
            return VStack(alignment: .trailing) {
                Text("Sure, you've been good.")
                    .font(.system(size: 20))
                content
            }
            .foregroundColor(.green)
        }
    }
}

extension View {
    func moneyModifier(for money: Int) -> some View {
        self.modifier(MoneyModifier(amount: money))
    }
}

struct ContentView: View {
    @ObservedObject var expenses = Expenses()
    @State var showAddView = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(expenses.items) { item in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(item.type)
                                .font(.system(size: 20))
                            Text(item.name)
                                .font(.system(size: 30))
                        }
                        Spacer()
                        Text("$\(item.amount)")
                            .font(.system(size: 30))
                            .moneyModifier(for: item.amount)
                    }
                }
                .onDelete(perform: removeItems)
            }
            
            .navigationBarTitle("iExpensive: Buy Later")
            .navigationBarItems(leading: EditButton(), trailing:
                Button(action: {
                    self.showAddView = true
                }) {
                    Image(systemName: "plus")
                }
            )
        }
        .sheet(isPresented: $showAddView) {
            AddView(expenses: self.expenses)
        }
    }
    
    func removeItems(at offset: IndexSet) {
        expenses.items.remove(atOffsets: offset)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
