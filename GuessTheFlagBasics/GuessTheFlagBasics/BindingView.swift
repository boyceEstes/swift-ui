//
//  BindingView.swift
//  GuessTheFlagBasics
//
//  Created by Boyce Estes on 6/12/20.
//  Copyright © 2020 Boyce Estes. All rights reserved.
//

import SwiftUI

// create a custom View
struct PushButton: View {
    // it contains a title
    let title: String
    @Binding var isOn: Bool

    // off colors change opacity
    var onColors = [Color.red, Color.yellow]
    var offColors = [Color(white: 0.6), Color(white: 0.4)]


    var body: some View {
        // there is a button that toggles the state property when presssed
        Button(title) {
            self.isOn.toggle()
        }
            // style
        .padding()
        .background(LinearGradient(gradient: Gradient(colors: isOn ? onColors : offColors), startPoint: .top, endPoint: .bottom))
        .foregroundColor(.white)
        .clipShape(Capsule())
        .shadow(radius: isOn ? 0 : 5)
    }
}

struct BindingView: View {
    @State private var rememberMe = false

    var body: some View {
        VStack {
            PushButton(title: "Remember Me", isOn: $rememberMe)
            Text(rememberMe ? "On" : "Off")
        }
    }
}

struct BindingView_Previews: PreviewProvider {
    static var previews: some View {
        BindingView()
    }
}
