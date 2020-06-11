//
//  Order.swift
//  CupcakeCorner
//
//  Created by Boyce Estes on 6/9/20.
//  Copyright © 2020 Boyce Estes. All rights reserved.
//

import Foundation

struct CakeOrder : Codable {
    var type = 0
    var quantity = 3
    var specialRequestEnabled = false {
        didSet {
            if specialRequestEnabled == false {
                extraFrosting = false
                addSprinkles = false
            }
        }
    }
    var extraFrosting: Bool = false
    var addSprinkles: Bool = false
    var name = ""
    var streetAddress = ""
    var city = ""
    var zip = ""
}

class Order : ObservableObject, Codable {
    enum CodingKeys: CodingKey {
//        case type, quantity, extraFrosting, addSprinkles, name, streetAddress, city, zip
        case cakeOrder
    }
    
    static let types = ["Vanilla", "Strawberry", "Chocolate", "Rainbow"]
    // each of these need to change when the UI changes so denote @Published
//    @Published var type: Int = 0
//    @Published var quantity: Int = 3
//
//    @Published var specialRequestEnabled: Bool = false {
//        didSet {
//            if specialRequestEnabled == false {
//                cakeOrder.extraFrosting = false
//                cakeOrder.addSprinkles = false
//            }
//        }
//    }
//    @Published var extraFrosting: Bool = false
//    @Published var addSprinkles: Bool = false
//
//    // address details
//    @Published var name = ""
//    @Published var streetAddress = ""
//    @Published var city = ""
//    @Published var zip = ""
    @Published var cakeOrder: CakeOrder = CakeOrder()
    
    var hasValidAddress: Bool {
        let nameText = cakeOrder.name.trimmingCharacters(in: .whitespacesAndNewlines)
        let streetAddressText = cakeOrder.streetAddress.trimmingCharacters(in: .whitespacesAndNewlines)
        let cityText = cakeOrder.city.trimmingCharacters(in: .whitespacesAndNewlines)
        let zipText = cakeOrder.zip.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if nameText == "" || streetAddressText == "" || cityText == "" || zipText == "" {
            return false
        }
        
        
        return true
    }
    
    var cost: Double {
        // $2 per cupcake
        var cost = Double(cakeOrder.quantity) * 2
        
        // complicated cupcakes cost more
        cost += (Double(cakeOrder.type) / 2)
        
        if cakeOrder.extraFrosting {
            cost += Double(cakeOrder.quantity) // $1 more each cupcake
        }
        
        if cakeOrder.addSprinkles {
            cost += Double(cakeOrder.quantity) / 2
        }
        
        return cost
    }
    
    init() {}
    
    required init(from decoder: Decoder)  throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        cakeOrder = try container.decode(CakeOrder.self, forKey: .cakeOrder)
//        type = try container.decode(Int.self, forKey: .type)
//        quantity = try container.decode(Int.self, forKey: .quantity)
//        extraFrosting = try container.decode(Bool.self, forKey: .extraFrosting)
//        addSprinkles = try container.decode(Bool.self, forKey: .addSprinkles)
//        name = try container.decode(String.self, forKey: .name)
//        streetAddress = try container.decode(String.self, forKey: .streetAddress)
//        city = try container.decode(String.self, forKey: .city)
//        zip = try container.decode(String.self, forKey: .zip)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(cakeOrder, forKey: .cakeOrder)
//        try container.encode(type, forKey: .type)
//        try container.encode(quantity, forKey: .quantity)
//        try container.encode(extraFrosting, forKey: .extraFrosting)
//        try container.encode(addSprinkles, forKey: .addSprinkles)
//        try container.encode(name, forKey: .name)
//        try container.encode(streetAddress, forKey: .streetAddress)
//        try container.encode(city, forKey: .city)
//        try container.encode(zip, forKey: .zip)
    }
}
