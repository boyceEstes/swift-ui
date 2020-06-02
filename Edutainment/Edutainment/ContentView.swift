//
//  ContentView.swift
//  Edutainment
//
//  Created by Boyce Estes on 5/29/20.
//  Copyright © 2020 Boyce Estes. All rights reserved.
//

import SwiftUI

struct OperandModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(size: 25, weight: .bold, design: .default))
    }
}

struct OperatorModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(size: 24))
    }
}

struct ButtonModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(.horizontal)
            .padding(.bottom, 10)
            .padding(.top, 10)
            .background(Color(.systemBlue))
            .foregroundColor(.white)
            .cornerRadius(10)
    }
}

//struct Card: View {
//
//    var body: some View {
//        LinearGradient(gradient: Gradient(colors: [Color(.systemBlue), .white]), startPoint: .topLeading, endPoint: .bottomTrailing)
//    }
//}

extension View {
    func operandModifier() -> some View {
        self.modifier(OperandModifier())
    }
    
    func operatorModifier() -> some View {
        self.modifier(OperatorModifier())
    }
    
    func buttonModifier() -> some View {
        self.modifier(ButtonModifier())
    }
}

struct ContentView: View {
    // displaying
    @State var gameOn: Bool = false
    @State var showAlert: Bool = false
    @State var alertTitle: String = ""
    @State var alertMessage: String = ""
    // settings
    @State var from: Double = 0
    @State var to: Double = 0
    @State var selectedNumberOfQuestions: Int = 0
    // game
    @State var questionsAnswered: Int = 0
    @State var answer: String = ""
    @State var score: Int = 0
    @State var operand1: Int = 0
    @State var operand2: Int = 0
    @State var expectedAnswer: Int = 0
    
    var numberOfQuestions = [1,5,10,20]
    
    var body: some View {
        Group {
            if gameOn {
                NavigationView {
                    VStack {
                        HStack {
                            Text("\(operand1)")
                                .operandModifier()
                            Text("X")
                                .operatorModifier()
                            Text("\(operand2)")
                                .operandModifier()
                        }
                        TextField("Answer", text: $answer)
                            .keyboardType(.numberPad)
                        Spacer()
                        Text("Score: \(score)")
                            .operandModifier()
                        Text("\(questionsAnswered)/\(numberOfQuestions[selectedNumberOfQuestions])")
                        Button("Submit") {
                            self.submitAnswer()
                        }
                            .buttonModifier()
                        
                    }
                    .navigationBarTitle("Play!")
                    .navigationBarItems(trailing:
                        Button("Reset Game") {
                            self.gameOn = false
                        }
                    )
                }
            } else {
                NavigationView {
                    ZStack {
//                        LinearGradient(gradient: Gradient(colors: [.pink, .gray]), startPoint: .bottomLeading, endPoint: .topTrailing)
//                            .edgesIgnoringSafeArea(.all)
                        VStack(alignment: .center) {
                            VStack(alignment: .leading, spacing: 30) {
                                
                                
                                VStack(alignment: .leading) {
                                    Text("Choose your range of multiplication")
                                        .font(.headline)
                                    
                                    HStack() {
                                       Text("From")
                                        .frame(width:40)
                                       Slider(value: $from, in: 0...12, step: 1.0)
                                        
                                        
                                    }
                                    
                                    HStack {
                                       Text("To")
                                        .frame(width:40)
                                       Slider(value: $to, in: 0...12, step: 1.0)
                                    }
                                    
                                    Text("Range: \(from, specifier: "%.f") to \(to, specifier: "%.f")")
                                }
                                .padding(.trailing, 20)
                                .padding(.leading, 20)

                                
                                VStack (alignment: .leading, spacing: 10) {
                                    Text("Number of questions")
                                        .font(.headline)
                                    Picker(selection: $selectedNumberOfQuestions, label: Text("")) {
                                        ForEach(0..<numberOfQuestions.count) {
                                            // give each segment a tag so it can be identified
                                            Text("\(self.numberOfQuestions[$0])").tag($0)
                                        }
                                    }
                                        .pickerStyle(SegmentedPickerStyle())
                                }
                                .padding(.trailing, 20)
                                .padding(.leading, 20)

                            }
                            .padding(10)
                            
                            Spacer()
                            Button("Start Game") {
                                self.startGame()
                            }
                                .buttonModifier()
                            Spacer()
                        }
                    }
                    .navigationBarTitle("Settings")
                }
            }
        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text(alertTitle), message: Text(alertMessage), dismissButton: .default(Text("OK")))
        }
    }
    
    func startGame() {
        if from > to {
            swap(&from, &to)
        }
        
        // start the game
        gameOn = true
        generateQuestion()
        score = 0
        questionsAnswered = 0

    }
    
    func generateQuestion() {
        operand1 = Int.random(in: Int(from)...Int(to))
        operand2 = Int.random(in: Int(from)...Int(to))
        expectedAnswer = operand1 * operand2
    }
    
    func submitAnswer() {
        if let ans = Int(answer) {

            if ans == expectedAnswer {
                // correct
                correct()
            } else {
                // wrong
                wrong()
            }
            
            questionsAnswered += 1
            
            if questionsAnswered >= numberOfQuestions[selectedNumberOfQuestions] {
                finish()
            } else {
                generateQuestion()
                self.answer = ""
            }
        } else {
            // display alert
            showAlert(title: "Input Invalid", message: "Answer with a number!")
        }
    }
    
    func finish() {
        showAlert(title: "Finished", message: "Your final score was \(score)/\(questionsAnswered)")
        gameOn = false
    }
    
    func correct() {
        // display
        score += 1
//        showAlert(title: "Correct", message: "Your score is now \(score)")
    }
    
    func wrong() {
//        showAlert(title: "Wrong", message: "Your score is now \(score)")
    }
    
    func showAlert(title: String, message: String) {
        alertTitle = title
        alertMessage = message
        showAlert = true
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
