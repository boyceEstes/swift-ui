//
//  AddView.swift
//  MilestoneTasks
//
//  Created by Boyce Estes on 6/6/20.
//  Copyright © 2020 Boyce Estes. All rights reserved.
//

import SwiftUI

struct AddView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var villains: Villains
    
    @State private var alias: String = ""
    @State private var description: String = ""
    @State private var powerRanking: Int = 1
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Alias", text: $alias)
                TextField("Description", text: $description)
                HStack {
                    Text("Power Ranking: \(powerRanking)/5")
                    Stepper("", value: $powerRanking, in: 1...5)
                }
            }
            .navigationBarItems(leading:
                Button("Cancel") {
                    self.presentationMode.wrappedValue.dismiss()
                },
                trailing:
                Button("Save") {
                    let candidate = Villain(alias: self.alias, description: self.description, powerRanking: self.powerRanking, votes: 0, profilePicName: self.alias)
                    self.villains.villainCandidates.append(candidate)
                    self.villains.villainCandidates = self.villains.villainCandidates
                    self.presentationMode.wrappedValue.dismiss()
                }
            )
            .navigationBarTitle("Add Candidate")
        }
    }
}

struct AddView_Previews: PreviewProvider {
    
    static var previews: some View {
        AddView(villains: Villains())
    }
}
