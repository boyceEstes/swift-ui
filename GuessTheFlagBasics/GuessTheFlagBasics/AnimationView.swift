//
//  Animation.swift
//  GuessTheFlagBasics
//
//  Created by Boyce Estes on 5/25/20.
//  Copyright © 2020 Boyce Estes. All rights reserved.
//

import SwiftUI

struct AnimationView: View {
//    @State private var scaleAmount: CGFloat = 1
//
//    var body: some View {
//        Button("Click Me") {
//            print("Clicked")
////            self.scaleAmount += 1
//        }
//        .padding(50)
//        .background(Color.blue)
//        .foregroundColor(.white)
//        .clipShape(Circle())
//        .overlay(
//            Circle()
//                .stroke(Color.blue)
//                .scaleEffect(scaleAmount)
//                .opacity(Double(2-scaleAmount)) //opacity 1 is opaque, 0 is tranparent
//            .animation(
//                Animation
//                    .easeOut(duration: 1)
//                    .repeatForever(autoreverses: false)
//            )
//        )
//        .onAppear {
//            self.scaleAmount = 2
//        }
//    }
    @State private var animationAmount: CGFloat = 1

    var body: some View {
        print("animationAmount: \(animationAmount)")
        
        return VStack {
            Stepper("Scale amount", value: $animationAmount.animation(), in: 1...10)

            Spacer()

            Button("Tap Me") {
                self.animationAmount += 1
            }
            .padding(40)
            .background(Color.red)
            .foregroundColor(.white)
            .clipShape(Circle())
            .scaleEffect(animationAmount)
        }
    }

}

struct Animation_Previews: PreviewProvider {
    static var previews: some View {
        AnimationView()
    }
}
