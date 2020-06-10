//
//  TaskDetailView.swift
//  MilestoneTasks
//
//  Created by Boyce Estes on 6/6/20.
//  Copyright © 2020 Boyce Estes. All rights reserved.
//

import SwiftUI

struct CandidateDetailView: View {
    @ObservedObject var villains: Villains
    var candidate: Villain
    var index: Int
    
    var body: some View {
        NavigationView {
            VStack {
                Image(candidate.profilePicName)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width:300, height: 300)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.red))
                Text(candidate.alias)
                    .font(.largeTitle)
                Text(candidate.description)
                Text("\(candidate.powerRanking)/5")
                
                HStack {
                    Text("Votes: \(self.villains.villainCandidates[self.index].votes)")
                    
                    Stepper("", onIncrement: {
                        //
                        self.villains.villainCandidates[self.index].votes += 1
                    }, onDecrement: {
                        if self.villains.villainCandidates[self.index].votes > 0 {
                            self.villains.villainCandidates[self.index].votes -= 1
                        }
                    })
                }
                Spacer()
            }
            
            .navigationBarTitle(Text("Details"))

        }
    }
}

struct TaskDetailView_Previews: PreviewProvider {
    static var previews: some View {
        CandidateDetailView(villains: Villains(), candidate: Villain(alias: "Joker", description: "Wild card. Honestly terrifies me. Probably would help as much as hurt.", powerRanking: 3, votes: 2, profilePicName: "Joker"), index: 0)
    }
}
