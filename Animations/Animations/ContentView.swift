//
//  ContentView.swift
//  Animations
//
//  Created by Boyce Estes on 3/19/20.
//  Copyright © 2020 Boyce Estes. All rights reserved.
//

import SwiftUI

struct CornerRotateModifier: ViewModifier {
    let amount: Double
    let anchor: UnitPoint
    
    func body(content: Content) -> some View {
        content.rotationEffect(.degrees(amount), anchor: anchor).clipped()
    }
}

extension AnyTransition {
    static var pivot: AnyTransition {
        .modifier(active: CornerRotateModifier(amount: -90, anchor: .topLeading), identity: CornerRotateModifier(amount: 0, anchor: .topLeading))
    }
}

struct ContentView: View {
    @State private var isShowingRed = false
    @State private var rotateAmount = 0.0

    var body: some View {
        VStack {
//            Button ("Tap Me") {
//                withAnimation {
//                    self.isShowingRed.toggle()
//                }
//            }
            Button (action: {
                // do nothing
                withAnimation {
                    self.rotateAmount += 360
                }
            }) {
                Text("Touch me")
            }
            .padding(50)
            .background(Color.blue)
            .foregroundColor(.white)
            .clipShape(Circle())
            .rotation3DEffect(.degrees(self.rotateAmount), axis: (x: 0, y: 1, z: 0))
            
            if isShowingRed {
                Rectangle()
                    .fill(Color.red)
                    .frame(width: 200, height: 200)
                    .transition(.pivot)
//                    .transition(.asymmetric(insertion: .scale, removal: .opacity))
            }
        }
    }
}
//struct ContentView: View {
////    @State private var animationAmount: CGFloat = 1
////    // rotation degrees are handled in Double data type
////    @State private var animationAmount2 = 0.0
////    @State private var enabled = false
//
//    @State private var dragAmount = CGSize.zero
//
//    var body: some View {
//        LinearGradient(gradient: Gradient(colors: [.yellow, .red]), startPoint: .topLeading, endPoint: .bottomTrailing)
//            .frame(width: 300, height: 300)
//            .clipShape(RoundedRectangle(cornerRadius: 10))
//            .offset(dragAmount)
//            .gesture(
//                DragGesture()
//                    .onChanged { self.dragAmount = $0.translation }
//                    .onEnded { _ in
//                        withAnimation(.spring()) {
//                            self.dragAmount = .zero
//                        }
//                    }
//            )
//    }
//}
//        Button("Tap Me") {
//            self.enabled = !self.enabled
//        }
//        .padding()
//        .background(enabled ? Color.blue : Color.red)
//        .animation(.default)
//        .foregroundColor(.white)
//        .clipShape(RoundedRectangle(cornerRadius: enabled ? 60 : 0))
//        .animation(.interpolatingSpring(stiffness: 10, damping: 1))
        
//        Button("Tap Me") {
//            // do nothing
//            withAnimation(.interpolatingSpring(stiffness:  5, damping: 1)) {
//                self.animationAmount2 += 360
//            }
//        }
//        .padding(50)
//        .background(Color.red)
//        .foregroundColor(.white)
//        .clipShape(Circle())
//        .rotation3DEffect(.degrees(animationAmount2), axis: (x: 0, y: 1, z: 0))
//        VStack {
//            Stepper("Scale amount", value: $animationAmount.animation(), in: 1...10)
//
//            Spacer()
//
//            Button("Tap Me") {
//                self.animationAmount += 1
//            }
//            .padding(40)
//            .background(Color.red)
//            .foregroundColor(.white)
//            .clipShape(Circle())
//            .scaleEffect(animationAmount)
//        }

        
//        Button("Tap me") {
////            self.animationAmount += 1
//        }
//        .overlay(
//            Circle()
//                .stroke(Color.red)
//                .scaleEffect(animationAmount)
//                .opacity(Double(2 - animationAmount))
//                .animation(
//                    Animation.easeOut(duration: 1)
//                        .repeatForever(autoreverses: false)
//                )
//        )
//        .onAppear {
//            self.animationAmount = 2
//        }
            /*
        .padding(50)
        .background(Color.red)
        .foregroundColor(.white)
        .clipShape(Circle())
        .scaleEffect(animationAmount)
        .blur(radius: (animationAmount - 1) * 3)
        .animation(
            Animation.easeInOut(duration: 2)
                .repeatCount(3, autoreverses: true)
        )
 */


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
