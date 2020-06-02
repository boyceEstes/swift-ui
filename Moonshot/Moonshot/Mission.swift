//
//  Mission.swift
//  Moonshot
//
//  Created by Boyce Estes on 5/31/20.
//  Copyright © 2020 Boyce Estes. All rights reserved.
//

import Foundation

struct Mission: Codable, Identifiable{
    struct CrewRole: Codable {
        let name: String
        let role: String
    }
    let id: Int
    let crew: [CrewRole]
    let description: String
    let launchDate: Date?
    
    var displayName: String {
        "Apollo \(id)"
    }
    
    var image: String {
        "apollo\(id)"
    }
    
    var displayDate: String {
        if let launchDate = launchDate {
            let formatter = DateFormatter()
            formatter.dateStyle = .long
            return formatter.string(from: launchDate)
        } else {
            return "N/A"
        }
    }
}
