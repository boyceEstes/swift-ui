//
//  CheckoutView.swift
//  CupcakeCorner
//
//  Created by Boyce Estes on 6/9/20.
//  Copyright © 2020 Boyce Estes. All rights reserved.
//

import SwiftUI

struct CheckoutView: View {
    @ObservedObject var order: Order
    
    var body: some View {
        NavigationView {
            GeometryReader { geo in
                ScrollView {
                    VStack {
                        Image("cupcakes")
                            .resizable()
                            .scaledToFit()
                            .frame(width: geo.size.width)
                        
                        Text("Your total is $\(self.order.cost, specifier: "%.2f")")
                            .font(.title)
                        
                        Button("Place Order") {
                            
                        }
                        .padding()
                    }
                }
            }
        }
    }
}

struct CheckoutView_Previews: PreviewProvider {
    static var previews: some View {
        CheckoutView(order: Order())
    }
}
