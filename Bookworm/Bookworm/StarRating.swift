//
//  StarRating.swift
//  Bookworm
//
//  Created by Boyce Estes on 6/13/20.
//  Copyright © 2020 Boyce Estes. All rights reserved.
//

import SwiftUI

struct StarRating: View {
    @Binding var rating: Int
    
    var maximumRating = 5
    var label = ""
    
    var offImage: Image?
    var onImage = Image(systemName: "star.fill")
    var onColor = Color.yellow
    var offColor = Color.gray
    
    var body: some View {
        HStack {
            if !label.isEmpty {
                Text(label)
            }
            ForEach(1..<maximumRating+1) { number in
                self.onOffStar(for: number)
                    .foregroundColor(number > self.rating ? self.offColor : self.onColor)
                    .onTapGesture {
                        self.rating = number
                }
            }
        }
    }
    
    func onOffStar(for number: Int) -> Image {
        if number > rating {
            return offImage ?? onImage
        } else {
            return onImage
        }
    }
}

struct StarRating_Previews: PreviewProvider {
    static var previews: some View {
        StarRating(rating: .constant(4))
    }
}
