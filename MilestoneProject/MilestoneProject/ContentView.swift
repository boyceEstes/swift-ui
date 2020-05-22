//
//  ContentView.swift
//  MilestoneProject
//
//  Created by Boyce Estes on 3/5/20.
//  Copyright © 2020 Boyce Estes. All rights reserved.
//

import SwiftUI

enum Weapon: String {
    case rock = "Rock"
    case scissors = "Scissors"
    case paper = "Paper"
}

enum GameState: Int {
    case startMenu
    case choice
    case score
}

struct ContentView: View {
    // rock paper scissors
    // win or lose
    // app choice for options, and for win or lose
    // player prompt to choose based on the app choice
    // score to handle
    // game loop that ends the game after 10 questions
    
    let weapons: [Weapon] = [.rock, .paper, .scissors]
    @State private var round: Int = 1
    @State private var score: Int = 0
    @State private var playerChoice: Weapon = .rock
    @State private var appChoice: Weapon = .rock
    @State private var playerGoal: Bool = true  // true means win
    @State private var prompt: GameState = .startMenu
    @State private var alertMessage: String = ""
    @State private var alertTitle: String = ""
    @State private var showAlert: Bool = false
    
    var body: some View {
        VStack {
            if prompt == .startMenu {
                Text("Rock Paper Scissors... Sortof!")
                Text("Press button to begin")
                Button(action: {
                    self.generateRoundData()
                    self.prompt = .choice
                }) {
                    Text("Start")
                }
            } else if prompt == .choice {
                // Player choice
                Form {
                    Text("Round \(round)!")
                    Text("To win this round you must \(playerGoal ? "win" : "lose") this hand of rock, paper, scissors. Your oppenent chose \(appChoice.rawValue)")
                
                    ForEach(weapons, id: \.self) { weapon in
                        Button(action: {
                            print("Clicked! \(weapon.rawValue)")
                            self.playerChoice = weapon
                            self.checkPlayerChoice()
                            self.showAlert = true
                            self.round += 1
                            if self.round == 10 {
                                self.prompt = .score
                            } else {
                                
                                self.generateRoundData()
                            }
                        }) {
                            Text(weapon.rawValue)
                        }
                    }
                }
                .alert(isPresented: $showAlert) {
                    Alert(title: Text(alertTitle), message: Text(alertMessage), dismissButton: .default(Text("OK")))
                }
            } else {
                // Score
                Text("The game is over.\n Your score is \(score)/10")
                
                Button(action: {
                    self.resetGame()
                }) {
                    Text("Restart Game")
                }
            }
        }
    }
    
    func resetGame() {
        score = 0
        round = 0
        prompt = .startMenu
    }
    
    // Three phases: Introduction, Game, Checking.
    func checkPlayerChoice() {
        let wrongTitle = "Wrong"
        let wrongMessage = "Oof. Come on. You can do better than that."
        // if the player choice beats the app choice
        if playerGoal == true {
            if appChoice == .rock {
                if playerChoice == .paper {
                    score += 1
                    alertTitle = "Good job!"
                    alertMessage = "Your score is now \(score)"
                } else {
                    
                    alertTitle = wrongTitle
                    alertMessage = wrongMessage
                    return
                }
            } else if appChoice == .paper {
                if playerChoice == .scissors {
                    score += 1
                    alertTitle = "Good job!"
                    alertMessage = "Your score is now \(score)"
                } else {
                    
                    alertTitle = wrongTitle
                    alertMessage = wrongMessage
                    return
                }
            } else {
                if playerChoice == .rock {
                    score += 1
                    alertTitle = "Good job!"
                    alertMessage = "Your score is now \(score)"
                } else {
                    
                    alertTitle = wrongTitle
                    alertMessage = wrongMessage
                    return
                }
            }
        } else {
            if appChoice == .rock {
                if playerChoice != .paper {
                    score += 1
                    alertTitle = "Good job!"
                    alertMessage = "Your score is now \(score)"
                } else {
                    
                    alertTitle = wrongTitle
                    alertMessage = wrongMessage
                    return
                }
            } else if appChoice == .paper {
                if playerChoice != .scissors {
                    score += 1
                    alertTitle = "Good job!"
                    alertMessage = "Your score is now \(score)"
                } else {
                    
                    alertTitle = wrongTitle
                    alertMessage = wrongMessage
                    return
                }
            } else {
                if playerChoice != .rock {
                    score += 1
                    alertTitle = "Good job!"
                    alertMessage = "Your score is now \(score)"
                } else {
                    
                    alertTitle = wrongTitle
                    alertMessage = wrongMessage
                    return
                }
            }
        }
    }
    
    func generateRoundData() {
        appChoice = weapons.randomElement() ?? .rock
        playerGoal = Bool.random()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
