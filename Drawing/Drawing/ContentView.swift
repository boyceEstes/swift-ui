//
//  ContentView.swift
//  Drawing
//
//  Created by Boyce Estes on 6/2/20.
//  Copyright © 2020 Boyce Estes. All rights reserved.
//

import SwiftUI

struct Arc: Shape {
    var startAngle: Angle
    var endAngle: Angle
    var clockwise: Bool


    func path(in rect: CGRect) -> Path {
        let rotationAdjustment = Angle.degrees(90)
        let modifiedStart = startAngle - rotationAdjustment
        let modifiedEnd = endAngle - rotationAdjustment
        
        var path = Path()
        path.addArc(center: CGPoint(x: rect.midX, y: rect.midY), radius: rect.width / 2, startAngle: modifiedStart, endAngle: modifiedEnd, clockwise: !clockwise)


        return path
    }
}

struct Flower: Shape {
    // move from center
    var petalOffset: Double = -20
    var petalWidth: Double = 100
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        for number in stride(from: 0, to: CGFloat.pi* 2, by: CGFloat.pi /8) {
            let rotation = CGAffineTransform(rotationAngle: number)
            let position = rotation.concatenating(CGAffineTransform(translationX: rect.width/2, y: rect.height /2))        }
    }
}

struct ContentView: View {
    var body: some View {
        Arc(startAngle: .degrees(0), endAngle: .degrees(110), clockwise: false)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
