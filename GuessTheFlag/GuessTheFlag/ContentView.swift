//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Boyce Estes on 2/27/20.
//  Copyright © 2020 Boyce Estes. All rights reserved.
//

import SwiftUI

struct Title: ViewModifier {
    func body(content: Content) -> some View {
        content
            .foregroundColor(.white)
            .font(.largeTitle)
//            .fontWeight(.black)
            .frame(width: 300)
    }
}


struct FlagImage: View {
    var imageName: String
    
    var body: some View {
        Image(imageName)
            .renderingMode(.original)
            .clipShape(Capsule())
            .overlay(Capsule().stroke(Color.black, lineWidth: 1))
            .shadow(color: .black, radius: 2)
    }
}

struct ContentView: View {
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"]
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var scoreTitle = ""
    @State private var scoreMessage = ""
    @State private var scoreShowing = false
    @State private var score = 0
    @State private var timeRemaining = 0
    @State private var rotateAmount: Double = 0
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.blue, .black]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)

            VStack(spacing: 50) {
                VStack {
                    Text("Tap the flag of")
                        .foregroundColor(.white)
                    Text(countries[correctAnswer])
                        .modifier(Title())
//                        .fixedSize(horizontal: false, vertical: true)
                }
                
                ForEach(0 ..< 3) { number in
                    Button(action: {
                        self.flagTapped(number)

                        withAnimation (.default) {
                            self.rotateAmount += 360
                        }
                    }) {
                        FlagImage(imageName: self.countries[number])
                            .rotation3DEffect(.degrees(number == self.correctAnswer ? self.rotateAmount : 0), axis: (x: 0, y: 1, z: 0))
                            
//                        Image(self.countries[number])
//                            .renderingMode(.original)
//                            .clipShape(Capsule())
//                            .overlay(Capsule().stroke(Color.black, lineWidth: 1))
//                            .shadow(color: .black, radius: 2)
                    }
                    
                }
                
                Text("Your score is \(score)")
                    .foregroundColor(.white)
                                
                Text("\(timeRemaining)")
                    .foregroundColor(.white)
                    .onReceive(timer) { _ in
                        if self.timeRemaining > 0 {
                            self.timeRemaining -= 1
                        } else if self.scoreShowing {
                            // askQuestion and make the text dissappear
                            self.askQuestion()
                            self.scoreShowing = false
                        }
                }
                
                Spacer()
            }
            
            if scoreShowing {
//                if scoreTitle == "Wrong" {
//                    Color.red
//                        .frame(width: 250, height: 130, alignment: .center)
//                    .overlay(Circle().stroke(Color.white, lineWidth: 2))
//                        .border(Color.black, width: 3)
//                } else {
//                    Color.green
//                        .frame(width: 250, height: 130, alignment: .center)
//                        .overlay(Circle())
//                        .border(Color.white, width: 3)
//                }
                
                RoundedRectangle(cornerRadius: 16)
                    .frame(width: 300, height: 150, alignment: .center)
                    .overlay(RoundedRectangle(cornerRadius: 16)
//                        .stroke(Color.white, lineWidth: 3)
                        .stroke(Color.black, lineWidth: 4))
                    .foregroundColor(scoreTitle == "Wrong" ? Color.red : Color.green)
                    


                VStack(spacing: 10) {
                    // show the text
                    Text(scoreTitle)
                        .font(.largeTitle)
                        .fontWeight(.black)
                        .foregroundColor(.white)
                    Text(scoreMessage)
                        .font(.subheadline)
                        .fontWeight(.medium)
                        .foregroundColor(.white)
                }

            }
        }
//        .alert(isPresented: $scoreShowing) {
//            Alert(title: Text(scoreTitle), message: Text(scoreMessage), dismissButton: .default(Text("Continue")) {
//                self.askQuestion()
//            })
//        }
    }
    
    func flagTapped(_ input: Int) {
        if input == correctAnswer {
            score += 1
            scoreTitle = "Correct!"
            scoreMessage = "Your score is \(score)"
        } else {
            scoreTitle = "Wrong"
            scoreMessage = "Dumb-dumb, that was \(countries[input])"
        }
        timeRemaining = 2
        scoreShowing = true
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
