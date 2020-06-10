//
//  MissionView.swift
//  Moonshot
//
//  Created by Boyce Estes on 5/31/20.
//  Copyright © 2020 Boyce Estes. All rights reserved.
//

import SwiftUI

struct MissionView: View {
    let mission: Mission
    let astronauts: [CrewMember]
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView(.vertical) {
                VStack {
                    Image(self.mission.image)
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: geometry.size.width * 0.7)
                        .padding(.top)
                    Text("Launch Date: \(self.mission.displayDate)")
                    Text(self.mission.description)
                        .padding()
                    
                    ForEach(self.astronauts, id: \.role) { crewMember in
                        NavigationLink(destination: AstronautView(astronaut: crewMember.astronaut, missions: Bundle.main.decode("missions.json"))) {
                            HStack {
                                 Image(crewMember.astronaut.id)
                                     .resizable()
                                     .frame(width: 83, height: 60)
                                 .clipShape(Capsule())
                                     .overlay(Capsule().stroke(Color.primary, lineWidth: 1))
                                 VStack(alignment: .leading) {
                                     Text(crewMember.astronaut.name)
                                         .font(.headline)
                                     Text(crewMember.role)
                                         .foregroundColor(.secondary)
                                 }
                                 Spacer()
                             }
                             .padding(.horizontal)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                    Spacer(minLength: 25)
                }
            }
        }
        .navigationBarTitle(Text(mission.displayName))
    }
    
    init(mission: Mission, astronautList: [Astronaut]) {
        self.mission = mission
        
        var matches = [CrewMember]()
        
        // go through each member in the mission, search for a matching member in astronautList
        for member in mission.crew {
            if let match = astronautList.first(where: {$0.id == member.name}) {
                matches.append(CrewMember(role: member.role, astronaut: match))
            } else {
                fatalError("Mission \(member)")
            }
        }
        astronauts = matches
    }
}

// to preview we need to pass in all uninitialized variables (mission)
struct MissionView_Previews: PreviewProvider {
    static var missions: [Mission] = Bundle.main.decode("missions.json")
    static var astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
    static var previews: some View {
        MissionView(mission: missions[0], astronautList: astronauts)
    }
}
