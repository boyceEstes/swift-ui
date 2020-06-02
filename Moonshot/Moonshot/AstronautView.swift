//
//  AstronautView.swift
//  Moonshot
//
//  Created by Boyce Estes on 5/31/20.
//  Copyright © 2020 Boyce Estes. All rights reserved.
//

import SwiftUI

struct AstronautView: View {
    let astronaut: Astronaut
    let missions: [Mission]
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView (.vertical) {
                VStack {
                    Image(self.astronaut.id)
                        .resizable()
                        .scaledToFit()
                        .frame(width: geometry.size.width)
                    
                    Text(self.astronaut.description)
                        .padding()
                        .layoutPriority(1)
                    
                    Text("Missions")
                        .font(.headline)
                    ForEach(self.missions, id: \.id) { mission in
                        HStack {
                            Image(mission.image)
                                .resizable()
                                .frame(width: 83, height: 60)
                                .clipShape(Capsule())
                                .overlay(Capsule()
                                .stroke(Color.primary, lineWidth: 1))
                            VStack(alignment: .leading) {
                                Text(mission.displayName)
                                    .font(.headline)
                                Text(mission.displayDate)
                                    .foregroundColor(.secondary)
                            }
                            Spacer()
                        }
                        .padding(.horizontal)
                    }
                }
            }
        }
        .navigationBarTitle(Text(astronaut.name), displayMode: .inline)
    }
    
    init(astronaut: Astronaut, missions: [Mission]) {
        self.astronaut = astronaut
        // given an astronaut and an array of missions.
        // for each crew we need to check all of their members for matches
        // Look through the missions, match them whenever they say the astronauts name
        var matched = [Mission]()
        for mission in missions {
            if mission.crew.first(where: {$0.name == astronaut.id}) != nil {
                matched.append(mission)
                continue
            }
        }
        self.missions = matched
    }
}

struct AstronautView_Previews: PreviewProvider {
    static var astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
    static var missions: [Mission] = Bundle.main.decode("missions.json")
    static var previews: some View {
        AstronautView(astronaut: astronauts[0], missions: missions)
    }
}
