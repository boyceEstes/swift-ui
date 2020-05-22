//
//  ContentView.swift
//  BetterRest
//
//  Created by Boyce Estes on 3/5/20.
//  Copyright © 2020 Boyce Estes. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    static var defaultWakeUpTime: Date {
        var component = DateComponents()
        component.hour = 7
        component.minute = 0
        return Calendar.current.date(from: component) ?? Date()
    }
    
    
    @State private var wakeUp = defaultWakeUpTime
    @State private var sleepAmount = 8.0
    @State private var coffeeAmount = 1
    @State private var alertShowing: Bool = false
    @State private var alertTitle: String = ""
    @State private var alertMessage: String = ""
    
    
    var body: some View {
        NavigationView {
            Form {
                Text("What time would you like to wake up?")
                    .font(.headline)
                DatePicker("Select wake up time", selection: $wakeUp, displayedComponents: .hourAndMinute)
                    .labelsHidden()
                    .datePickerStyle(WheelDatePickerStyle())
                
                VStack{
                    Text("Desired amount of sleep time")
                        .font(.headline)
            
                    Stepper(value: $sleepAmount, in: 4...12, step:0.25) {
                        Text("\(sleepAmount, specifier: "%g") hours")
                    }
                }

                
                VStack {
                     Text("Daily coffee intake")
                         .font(.headline)
                
                     Stepper(value: $coffeeAmount, in: 1...20) {
                         if coffeeAmount == 1 {
                             Text("1 cup")
                         } else {
                             Text("\(coffeeAmount) cups")
                         }
                     }
                }

            
                Button (action: {
                    self.calculateBedtime()
                }) {
                    Text("Calculate bedtime!")
                }
            }
            .alert(isPresented: $alertShowing) {
                Alert(title: Text(alertTitle), message: Text(alertMessage), dismissButton: .default(Text("OK")))
            }
        }
        .navigationBarTitle(Text("BetterRest"))
        .navigationBarItems(trailing:
            Button (action: self.calculateBedtime) {
                Text("Calculate bedtime!")
            }
        )
    }
    
    func calculateBedtime() {
        let model = SleepCalculator()
        let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
        let hour = (components.hour ?? 0) * 60 * 60
        let minute = (components.minute ?? 0) * 60
        
        do {
            let prediction = try model.prediction(wake: Double(hour + minute), estimatedSleep: sleepAmount, coffee: Double(coffeeAmount))
            let bedTime: Date = wakeUp - prediction.actualSleep
            
            let formatter = DateFormatter()
            formatter.timeStyle = .short
            
            alertTitle = "Your ideal bedtime is..."
            alertMessage = formatter.string(from: bedTime)
        } catch {
            print("Something went wrong")
            alertTitle = "Error"
            alertMessage = "Could not successfully calculate your bedtime."
        }
        
        alertShowing = true
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
