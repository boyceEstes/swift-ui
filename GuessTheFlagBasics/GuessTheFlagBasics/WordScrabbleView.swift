//
//  SwiftUIView.swift
//  GuessTheFlagBasics
//
//  Created by Boyce Estes on 5/24/20.
//  Copyright © 2020 Boyce Estes. All rights reserved.
//

import SwiftUI

struct WordScrabbleView: View {
    @State private var usedWords: [String] = []
    @State private var rootWord: String = ""
    @State private var newWord: String = ""
    @State private var score: Int = 0
    // error alert
    @State private var showError: Bool = false
    @State private var titleError: String = ""
    @State private var messageError: String = ""
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("Enter your word...", text: $newWord, onCommit: addNewWord)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .autocapitalization(.none)
                    .padding()
                List(usedWords, id: \.self) {
                    Image(systemName: "\($0.count).circle.fill")
                    Text($0)
                }
                Text("Score is \(score)")
            }
            .navigationBarTitle(rootWord)
            .navigationBarItems(leading: Button("Restart"){
                self.startGame()
            })
        }
        .onAppear(perform: startGame)
        .alert(isPresented: $showError) {
            Alert(title: Text(titleError), message: Text(messageError), dismissButton: .default(Text("OK")))
        }
    }
    
    func addNewWord() {
        let lowerNewWord = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        guard lowerNewWord.count > 0 else {
            print("All content was removed")
            return
        }
        guard extraValidation(newWord: lowerNewWord) else {
            wordError(title: "Error", message: "You failed our ultra, extra validation system.")
            return
        }
        
        if isOriginal(newWord: lowerNewWord) {
            if isPossible(newWord: lowerNewWord) {
                if isReal(newWord: lowerNewWord) {
                    usedWords.insert(lowerNewWord, at: 0)
                    newWord = ""
                    let calculatedScore = lowerNewWord.count * (usedWords.count)
                    print(calculatedScore)
                    score += calculatedScore // includes the word we just added
                    
                } else {
                    
                    wordError(title: "Error", message: "Not Real. What nonsense are you spouting?")
                }
            } else {
                wordError(title: "Error", message: "Not Possible. You sneaky bugger. Try a word that meets the requirements.")
            }
        } else {
            wordError(title: "Error", message: "Not original. Little plagerist.")
        }
    }
    
    // isOriginal (has it been used already)
    func isOriginal(newWord: String) -> Bool {
//        if usedWords.contains(newWord) {
//            return false
//        } else {
//            return true
//        }
        !usedWords.contains(newWord)
    }
    // isPossible (can it be made)
    func isPossible(newWord: String) -> Bool {
        // get the characters and the number of characters in the root word
        var temp = rootWord
        for letter in newWord {
            if let pos = temp.firstIndex(of: letter) {
                temp.remove(at: pos)
            } else {
                return false
            }
        }
        
        return true
    }
    
    // isReal (is it a real word)
    func isReal(newWord: String) -> Bool {
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: newWord.count)
        let misspellingRange = checker.rangeOfMisspelledWord(in: newWord, range: range, startingAt: 0, wrap: false, language: "en")
        return misspellingRange.location == NSNotFound
    }
    
    func extraValidation(newWord: String) -> Bool {
        if newWord.count < 3 {
            return false
        }
        
        if newWord == rootWord {
            return false
        }
        
        return true
    }
    
    func wordError(title: String, message: String) {
        showError = true
        titleError = title
        messageError = message
    }
    
    
    func startGame() {
        if let url = Bundle.main.url(forResource: "start", withExtension: "txt") {
            if let fileContents = try? String(contentsOf: url) {
                let allWords = fileContents.components(separatedBy: "\n")
                score = 0
                usedWords = []
                rootWord = allWords.randomElement() ?? "silkworm"
                return
            } else {
                fatalError("No contents found at given URL")
            }
        } else {
            fatalError("No Contents file found")
        }
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        WordScrabbleView()
    }
}
