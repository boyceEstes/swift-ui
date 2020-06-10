//
//  Order.swift
//  CupcakeCorner
//
//  Created by Boyce Estes on 6/9/20.
//  Copyright © 2020 Boyce Estes. All rights reserved.
//

import Foundation

class Order : ObservableObject {
    static let types = ["Vanilla", "Strawberry", "Chocolate", "Rainbow"]
    // each of these need to change when the UI changes so denote @Published
    @Published var type: [String]!
    @Published var quantity: Int = 3
    @Published var specialRequestEnabled: Bool = false {
        didSet {
            if specialRequestEnabled == false {
                extraFrosting = false
                addSprinkles = false
            }
        }
    }
    @Published var extraFrosting: Bool = false
    @Published var addSprinkles: Bool = false
    
    // address details
    @Published var name = ""
    @Published var streetAddress = ""
    @Published var city = ""
    @Published var zip = ""
    
    var hasValidAddress: Bool {
        if name.isEmpty || streetAddress.isEmpty || city.isEmpty || zip.isEmpty {
            return false
        }
        return true
    }
    
    var cost: Double {
        // $2 per cupcake
        var cost = Double(quantity) * 2
        
        // complicated cupcakes cost more
//        cost += (Double(type) / 2)
        
        if extraFrosting {
            cost += Double(quantity) // $1 more each cupcake
        }
        
        if addSprinkles {
            cost += Double(quantity) / 2
        }
        
        return cost
    }
}
