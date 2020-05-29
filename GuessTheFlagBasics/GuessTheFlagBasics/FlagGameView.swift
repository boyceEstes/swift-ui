//
//  ContentView.swift
//  GuessTheFlagBasics
//
//  Created by Boyce Estes on 5/22/20.
//  Copyright © 2020 Boyce Estes. All rights reserved.
//

import SwiftUI

/*
 * Basic Picker and State variable
 *
 *

struct ContentView: View {
    let students = ["harry", "ron", "hermione"]
    @State private var selectedStudent = 0
    
    var body: some View {
        VStack {
            Text("Hello, World!")
            Picker("Select your favorite!", selection: $selectedStudent) {
                ForEach(0..<students.count) {
                    Text(self.students[$0])
                }
            }
            Text("You chose: Student #\(students[selectedStudent])")
        }
    }
}
  */



struct BasicFlagModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .clipShape(Capsule())
            .overlay(Capsule()
            .stroke(Color.black, lineWidth: 3))
            .shadow(radius: 2)
    }
}

struct RoundedRectangleFlagModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .clipShape(RoundedRectangle(cornerRadius: 5.0))
            .overlay(RoundedRectangle(cornerRadius: 5.0)
            .stroke(Color.black, lineWidth: 3))
            .shadow(radius: 2)
    }
}

extension View {
    func roundedRectangleFlag() -> some View{
        return ModifiedContent(content: self, modifier: RoundedRectangleFlagModifier())
    }
}


struct FlagGameView: View {
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"]
    // must initialize variables
    @State private var correctIndex: Int = Int.random(in: 0...2)
    @State private var score: Int = 0
    // For displaying Alert Score
    @State private var alertDisplaying = false
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    // Animations
    @State private var animationAmountCorrect = 0.0 // rotate
    @State private var animationAmountWrong = 1.0 // opacity amount
    @State private var animationAmountWrongAnswer: CGFloat = 1.0 // scale amount
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.pink, .gray]), startPoint: .bottom, endPoint: .top).edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 30) {
                // Intro
                VStack(spacing: 10) {
                    Text("Choose the correct Basic Flag")
                    // Flag variable needs to change
                    Text(countries[correctIndex])
                }
                // Flag Selection
                VStack(spacing: 15) {
                    ForEach(0..<3) {i in
                        // First three flags
                        Button(action: {
                            self.tapButton(index: i)
                        }) {
                            Image(self.countries[i])
                            .renderingMode(.original)
                            .roundedRectangleFlag()
                        }
                        .rotation3DEffect(.degrees(i == self.correctIndex ? self.animationAmountCorrect : 0), axis: (x: 0, y: 1, z: 0))
                        .opacity(self.animationAmountWrong)
                        .scaleEffect(i == self.correctIndex ? CGFloat(1) : self.animationAmountWrongAnswer)
             
                    }
                }
                // Score
                Text("You have gotten \(self.score) correct!")
                Spacer()
            }
        }
        .alert(isPresented: $alertDisplaying) {
            Alert(title: Text(alertTitle), message: Text(alertMessage), dismissButton: .default(Text("Ok Boomer")) {
                self.reloadGame()
            })
        }
    }
    // will turn toggle alertDisplaying by itself after dismiss Button is selected
    
    func tapButton(index: Int) {
        print("tapped \(index)")
        if correctIndex == index {
            // tappped the correct answer
            
            withAnimation(.default) {
                animationAmountWrong = 0.3
                animationAmountCorrect += 360
            }
            score += 1
            alertTitle = "Correct"
            alertMessage = "Smarty-pants"
            print("Correct")
        } else {
            withAnimation(.default) {
                self.animationAmountWrongAnswer = 0
            }
            alertTitle = "Wrong"
            alertMessage = "Try again"
            print("Wrong")
        }
        alertDisplaying = true
    }
    
    func reloadGame() {
        print("Reload Game")
        countries.shuffle()
        correctIndex = Int.random(in: 0...2)
        
        // reset animation values
        self.animationAmountCorrect = 0
        self.animationAmountWrong = 1
        self.animationAmountWrongAnswer = 1
        
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        FlagGameView()
    }
}
