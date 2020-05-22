//
//  ContentView.swift
//  ViewsAndModifiers
//
//  Created by Boyce Estes on 3/2/20.
//  Copyright © 2020 Boyce Estes. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Text("Hello World")
        .padding()
            .background(Color.red)
        .padding()
            .background(Color.blue)
        .padding()
            .background(Color.yellow)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
