//
//  ContentView.swift
//  MilestoneTasks
//
//  Created by Boyce Estes on 6/6/20.
//  Copyright © 2020 Boyce Estes. All rights reserved.
//

import SwiftUI

struct ImageInCircleModifier: ViewModifier {

    func body(content: Content) -> some View {
        content
            .frame(width:50, height: 50)
            .clipShape(Circle())
            .overlay(Circle().stroke(Color.red))
    }
}

extension Image {
    func putImageInCircle() -> some View {
        self.modifier(ImageInCircleModifier())
    }
}

struct RowContent: View {
    let villain: Villain
    
    var body: some View {
        HStack {
            Image(villain.profilePicName)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width:100, height: 100)
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.red))
            Spacer()
            VStack(alignment: .trailing) {
                Text(villain.alias)
                    .font(.largeTitle)
                VStack(alignment: .trailing){
                    Text("Power Ranking: \(villain.powerRanking)/5")
                        .font(.subheadline)
                        .padding([.bottom])
                    Text("Votes: \(String(villain.votes))")
                        .font(.subheadline)
                        .padding([.bottom])
                }
            }
        }
    }
}

struct Villain {
    var alias: String
    var description: String
    var powerRanking: Int
    var votes: Int
    var profilePicName: String
}

class Villains: ObservableObject {
    @Published var villainCandidates: [Villain] = [
        Villain(alias: "Joker", description: "Wild card. Honestly terrifies me. Probably would help as much as hurt.", powerRanking: 3, votes: 2, profilePicName: "Joker"),
        Villain(alias: "Dr. Octopus", description: "Smart. Skilled. A little ambitious. Lots of practical potential", powerRanking: 3, votes: 5, profilePicName: "Octopus")
        ] {
        didSet {
            print("Items were set. Encode \(villainCandidates.count)")
            // encode
        }
        
        // init() decode
    }
}


struct ContentView: View {
    @ObservedObject var villains = Villains()
    @State var showAddView = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(0..<villains.villainCandidates.count) { index in
                    NavigationLink(destination: CandidateDetailView(villains: self.villains, candidate: self.villains.villainCandidates[index], index: index)) {
                        RowContent(villain: self.villains.villainCandidates[index])
                    }
                }
            }
            .navigationBarItems(trailing:
                Button("Add Candidate") {
                    self.showAddView = true
                }
            )
            .navigationBarTitle("Villainous Recruitment")
            
        }
        .sheet(isPresented: $showAddView) {
            AddView(villains: self.villains)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
