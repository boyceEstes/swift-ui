//
//  ArcView.swift
//  DrawingDemo
//
//  Created by Boyce Estes on 6/4/20.
//  Copyright © 2020 Boyce Estes. All rights reserved.
//

import SwiftUI

struct Arc: InsettableShape {
    var startAngle: Angle
    var endAngle: Angle
    var clockwise: Bool
    var insetAmount: CGFloat = 0
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.addArc(center: CGPoint(x: rect.midX, y: rect.midY), radius: rect.width/2-insetAmount, startAngle: startAngle, endAngle: endAngle, clockwise: clockwise)
        
        return path
    }
    
    func inset(by amount: CGFloat) -> some InsettableShape {
        var arc = self
        arc.insetAmount += amount
        return arc
    }
}

struct ArcView: View {
    var body: some View {
        Arc(startAngle: .degrees(0), endAngle: .degrees(110), clockwise: true, insetAmount: 3)
            .strokeBorder(Color.blue, lineWidth:30)
            .frame(width: 300, height: 300)
    }
}

struct ArcView_Previews: PreviewProvider {
    static var previews: some View {
        ArcView()
    }
}
