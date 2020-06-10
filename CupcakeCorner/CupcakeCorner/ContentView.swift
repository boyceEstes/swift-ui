//
//  ContentView.swift
//  CupcakeCorner
//
//  Created by Boyce Estes on 6/9/20.
//  Copyright © 2020 Boyce Estes. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    // only place in the object that the order is created. Shared everywhere else it is used
    @ObservedObject var order = Order()
    var body: some View {
        NavigationView {
            Form {
                Section {
                    Picker("Select cupcake type", selection: $order.type) {
                        // should not need to specify id because fixed data but it prevents a strange warning
                        ForEach(0..<Order.types.count, id: \.self) {
                            Text(Order.types[$0])
                        }
                    }
            //        .pickerStyle(SegmentedPickerStyle())
                    // number of cupcakes
                    Stepper(value: $order.quantity, in: 3...20) {
                        Text("Number of cakes: \(order.quantity)")
                    }
                }
                
                Section {
                    // (modifier on the variable makes it transition smoother
                    Toggle(isOn: $order.specialRequestEnabled.animation()) {
                        Text("Any special requests?")
                    }

                    if order.specialRequestEnabled {
                        Toggle(isOn: $order.extraFrosting) {
                            Text("Add extra frosting")
                        }

                        Toggle(isOn: $order.addSprinkles) {
                            Text("Add extra sprinkles")
                        }
                    }
                }
                    
                Section {
                    Section {
                        NavigationLink(destination: AddressView(order: order)) {
                            Text("Delivery details")
                        }
                    }
                }
                    .navigationBarTitle("Cupcake Corner")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
