//
//  AddView.swift
//  iExpense
//
//  Created by Boyce Estes on 5/27/20.
//  Copyright © 2020 Boyce Estes. All rights reserved.
//

import SwiftUI

struct AddView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var expenses: Expenses
    
    
    @State var name: String = ""
    @State var type: String = ""
    @State var cost: String = ""
    
    static let types = ["Personal", "Business"]
    
    var body: some View {
        
        NavigationView {
            Form {
                TextField("Name", text: $name)
                Picker("Type", selection: $type) {
                    ForEach(Self.types, id:\.self) {
                        Text($0)
                    }
                }
                TextField("Amount", text: $cost)
                    .keyboardType(.numberPad)
            }
            .navigationBarTitle("Add Expense")
            .navigationBarItems(trailing:
                Button("Save") {
                    if let amount = Int(self.cost) {
                        let expense = ExpenseItem(name: self.name, type: self.type, amount: amount)
                        self.expenses.items.append(expense)
                        self.expenses.items = self.expenses.items
                        self.presentationMode.wrappedValue.dismiss()
                    }
                }
            )
        }
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView(expenses: Expenses())
    }
}
