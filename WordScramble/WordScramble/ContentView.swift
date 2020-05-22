//
//  ContentView.swift
//  WordScramble
//
//  Created by Boyce Estes on 3/13/20.
//  Copyright © 2020 Boyce Estes. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    // it is important to have a unique id for each row in a list
    // so that it can be easily removed or changed instead of reloading all elements
    
    // to set the id in an array full of something like strings use \.self
    // MARK: Basic variables
    @State private var usedWords = [String]()
    @State private var rootWord = ""
    @State private var newWord = ""
    @State private var score = 0
    
    // MARK: Error handling
    @State private var errorTitle = ""
    @State private var errorMessage = ""
    @State private var showingError = false
    
//    let fileContents: [String] = readFile()!
   
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("Enter your word", text: $newWord, onCommit: addNewWord)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                    .autocapitalization(.none)
                
                // this is a problem if there are reused words in the list
                List(usedWords, id: \.self) {
                    Image(systemName: "\($0.count).circle")
                    Text($0)
                }
                
                Text("Your score is: \(score)")
            }
            .navigationBarTitle(rootWord)
            .navigationBarItems(trailing:
                Button(action: {
                    self.startGame()
                }) {
                    Text("Scramble!")
                }
            )
            .onAppear(perform: startGame)
            .alert(isPresented: $showingError) {
                Alert(title: Text(errorTitle), message: Text(errorMessage), dismissButton: .default(Text("OK")))
            }
        }
    }
    
    // MARK: Error handling
    func wordError(title: String, message: String) {
        errorTitle = title
        errorMessage = message
        showingError = true
    }
    
    // MARK: Validating words
    func isNotRootWord(word: String) -> Bool {
        return word != rootWord
    }
    
    func isOriginal(word: String) -> Bool {
        !usedWords.contains(word)
    }
    
    func isPossible(word: String) -> Bool {
        var tempWord = rootWord

        for letter in word {
            if let pos = tempWord.firstIndex(of: letter) {
                tempWord.remove(at: pos)
            } else {
                return false
            }
        }

        return true
    }

    func isReal(word: String) -> Bool {
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        
        
        // word has to be at least 3 characters
        if word.count < 3 {
            return false
        }
        
        return misspelledRange.location == NSNotFound
    }
    
    // MARK: Base functionality
    
    func addNewWord() {
        // lowercase and trim the word, to make sure we don't add any duplicate words with case differences
        let answer = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        
        // exit if the remaining string is empty
        guard answer.count > 0 else {
            return
        }
        
        // extra validation
        guard isNotRootWord(word: answer) else {
            wordError(title: "Try again", message: "Come on. Be a little more original")
            return
        }
        
        guard isOriginal(word: answer) else {
            wordError(title: "Word used already", message: "Try a different word")
            return
        }
        
        guard isPossible(word: answer) else {
            wordError(title: "Word not possible", message: "Classic blunder.")
            return
        }
        
        guard isReal(word: answer) else {
            wordError(title: "Word not real", message: "Is imagination land fun?")
            return
        }
        
        score += (answer.count-2)*answer.count
        
        usedWords.insert(answer, at: 0)
        newWord = ""
    }
    
    func startGame() {
        if let startWordsURL = Bundle.main.url(forResource: "start", withExtension: "txt") {
            if let startWords = try? String(contentsOf: startWordsURL) {
                let allWords = startWords.components(separatedBy: "\n")
                
                rootWord = allWords.randomElement() ?? "silkworm"
                score = 0
                
                return
            }
        }
    }

}

    // unnecessary to the project but good for learning the API
func checkSpelling(word: String) -> Bool {
    let checker = UITextChecker()
    let range = NSRange(location: 0, length: word.utf16.count)
    let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
    
    if misspelledRange.location == NSNotFound {
        return true
    }
    
    return false
}

func readFile() -> [String]?{
    if let fileURL = Bundle.main.url(forResource: "start", withExtension: "txt") {
        // do stuff
        if let fileContents = try? String(contentsOf: fileURL) {
            // we loaded the file into a string!
            let fileContentsArray: [String] = fileContents.components(separatedBy: "\n")
            return fileContentsArray
            
        } else {
            print("could not load file into a string")
        }
    } else {
        print("Could not find the file URL")
    }
    return nil
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
