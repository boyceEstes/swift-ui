//
//  ContentView.swift
//  DrawingDemo
//
//  Created by Boyce Estes on 6/4/20.
//  Copyright © 2020 Boyce Estes. All rights reserved.
//

import SwiftUI

struct Arrow: InsettableShape {
    var insetAmount: CGFloat = 0
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.maxX, y: rect.maxY/2))
        path.addLine(to: CGPoint(x: rect.maxX*3/4+insetAmount*0.4, y: rect.minY+insetAmount*1.5))
        path.addLine(to: CGPoint(x: rect.maxX*3/4+insetAmount*0.4, y: rect.maxY*0.25+insetAmount*0.75))
        path.addLine(to: CGPoint(x: rect.minX+insetAmount, y: rect.maxY*0.25+insetAmount*0.75))
        path.addLine(to: CGPoint(x: rect.minX+insetAmount, y: rect.maxY*3/4-insetAmount*0.75))
        path.addLine(to: CGPoint(x: rect.maxX*3/4+insetAmount*0.4, y: rect.maxY*3/4-insetAmount*0.75))
        path.addLine(to: CGPoint(x: rect.maxX*3/4+insetAmount*0.4, y: rect.maxY-insetAmount*1.5))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY/2))
        return path
        
//        let rotation = CGAffineTransform(rotationAngle: 0)
//        let position = rotation.concatenating(CGAffineTransform(translationX: rect.width, y: rect.height))
//        let newPath = path.applying(position)
//        return newPath
    }
    
    func inset(by amount: CGFloat) -> some InsettableShape {
        var arrow = self
        arrow.insetAmount += amount
        return arrow
    }
}

struct ColorCyclingRectangle: View {
    var amount = 0.0
    var steps = 100
    var rotation = 0.0
    
    var body: some View {
//        GeometryReader { geometry in
        ZStack {
            
                ForEach(0..<self.steps) { value in
                    Arrow()
                        
                        .inset(by: CGFloat(value))
                        .strokeBorder(LinearGradient(gradient: Gradient(colors:[ self.color(for: value, brightness: 1), self.color(for: value, brightness: 0.5)]), startPoint: .top, endPoint: .bottom), lineWidth: 2)
                        .rotationEffect(Angle(degrees: self.rotation))
                        
                }
            }
//        }
            .drawingGroup()
    }
    
    func color(for value: Int, brightness: Double) -> Color {
        var targetHue = Double(value) / Double(self.steps) + self.amount
        if targetHue > 1 {
            targetHue -= 1
        }
        
        return Color(hue: targetHue, saturation: 1, brightness: brightness)
    }
}

struct ArrowView: View {
    @State private var rotation = 0.0
    @State private var colorCycle = 0.0
    
    var body: some View {
        VStack {
            
            ColorCyclingRectangle(amount: self.colorCycle, rotation: self.rotation)
                .frame(width: 300, height: 300)
            
            HStack {
                VStack {
                    Text("Color")
                    Text("Rotation")
                }
                VStack {
                    Slider(value: $colorCycle)
                    Slider(value: $rotation, in: 0...360)
                }
            }

            
//
//            Stepper(onIncrement: {
//                self.changeThickness(increment: true, amount: 3)
//            }, onDecrement: {
//                self.changeThickness(increment: false, amount: 3)
//            }) {
//                Text("Rotation")
//            }
        }
    }
    
//    func changeThickness(increment: Bool, amount: CGFloat) {
//        withAnimation {
//            increment ? (lineThickness += amount) : (lineThickness -= amount)
//        }
//    }
}


struct ContentView: View {
    @State private var lineThickness: CGFloat = 3
    @State private var colorCycle = 0.0
    
    var body: some View {
        VStack {
            ArrowView()
                .padding([.horizontal, .bottom])
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
