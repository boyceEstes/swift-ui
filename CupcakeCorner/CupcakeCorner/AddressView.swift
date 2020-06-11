//
//  AddressView.swift
//  CupcakeCorner
//
//  Created by Boyce Estes on 6/9/20.
//  Copyright © 2020 Boyce Estes. All rights reserved.
//

import SwiftUI

struct AddressView: View {
    @ObservedObject var order: Order
    
    
    var body: some View {
        // this is already embedded in a navigation controller
        Form {
            Section {
                TextField("Name", text: $order.cakeOrder.name)
                TextField("Street Address", text: $order.cakeOrder.streetAddress)
                TextField("City", text: $order.cakeOrder.city)
                TextField("Zip", text: $order.cakeOrder.zip)
            }
            
            Section {
                NavigationLink(destination: CheckoutView(order: order)) {
                    Text("Check out")
                }
            }
            .disabled(order.hasValidAddress == false)
        }
        .navigationBarTitle("Delivery Details")
        
    }
}

struct AddressView_Previews: PreviewProvider {
    static var previews: some View {
        AddressView(order: Order())
    }
}
