//
//  ContentView.swift
//  Moonshot
//
//  Created by Boyce Estes on 5/30/20.
//  Copyright © 2020 Boyce Estes. All rights reserved.
//

import SwiftUI


struct ContentView: View {
    @State private var crewNames = false // crew names are not showing
    
    let missions: [Mission] = Bundle.main.decode("missions.json")
    let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
    
    
    var body: some View {
        NavigationView {
            List(missions) { mission in
                NavigationLink(destination: MissionView(mission: mission, astronautList: self.astronauts)) {
                    Image(mission.image)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 44, height: 44)
                    VStack(alignment: .leading) {
                        Text(mission.displayName)
                            .font(.headline)
                        Group {
                            if self.crewNames {
                                Text(self.buildCrewString(mission: mission))
//                                ForEach(0..<mission.crew.count) { i in
//                                    HStack {
//                                        Text(mission.crew[i].name)
//                                        Spacer()
//                                        Text(mission.crew[i].role)
//                                            .foregroundColor(.secondary)
//                                    }
//                                        .padding(3)
//                                }
                            } else {
                                Text(mission.displayDate)
                            }
                        }
                    }
                }
            }
            .navigationBarTitle("Moonshot")
            .navigationBarItems(trailing: Button(crewNames ? "Date" : "Crew") {
                // showing dates is default, clicking this should show crew names
                self.crewNames.toggle()
            })
        }
    }
    
    func buildCrewString(mission: Mission) -> String{
        var crew: String = ""
        for i in 0..<mission.crew.count {
            crew += "\(mission.crew[i].name.capitalized)"
            if i != mission.crew.count - 1 {
                crew += ", "
            }
        }
        return crew
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
