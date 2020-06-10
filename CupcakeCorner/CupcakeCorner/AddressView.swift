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
        NavigationView {
            Form {
                Section {
                    TextField("Name", text: $order.name)
                    TextField("Street Address", text: $order.streetAddress)
                    TextField("City", text: $order.city)
                    TextField("Zip", text: $order.zip)
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
}

struct AddressView_Previews: PreviewProvider {
    static var previews: some View {
        AddressView(order: Order())
    }
}
