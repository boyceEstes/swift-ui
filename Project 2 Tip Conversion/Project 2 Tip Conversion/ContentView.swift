//
//  ContentView.swift
//  Project 2 Tip Conversion
//
//  Created by Boyce Estes on 2/26/20.
//  Copyright © 2020 Boyce Estes. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var inputTons: String = ""
    @State private var inputPounds: String = ""
    @State private var inputOunces: String = ""
    @State private var input: String = ""
    @State private var inputUnit: Int = 0
    @State private var inputType: Bool = false // inputType false = picker input
    @State private var outputUnit: Int = 0
    
    let inputUnits: [String] = ["Ounces", "Pounds", "Tons"]
    let outputUnits: [String] = ["Grams", "Kilograms"]
    
    // computed value to calculate the output
    var output: Double {
        var convertedInputValue: Double = 0.0
        if inputType {
            let inputTonsValue: Double = Double(inputTons) ?? 0.0
            let inputPoundsValue: Double = Double(inputPounds) ?? 0.0
            let inputOuncesValue: Double = Double(inputOunces) ?? 0.0
            
            convertedInputValue += inputOuncesValue
            convertedInputValue += inputPoundsValue * 16.0
            convertedInputValue += inputTonsValue * 32_000.0
        } else {
            let inputValue: Double = Double(input) ?? 0.0
            convertedInputValue += inputValue
            // For whatever unit is given we will convert to ounces
            switch inputUnit {
            case 0:
                break // do nothing, we already have units in ounces
            case 1:
                convertedInputValue = inputValue * 16 // 1 lb = 16 oz
            case 2:
                convertedInputValue = inputValue * 32_000 // 1 ton = 32000 oz
            default:
                break
            }
        }

        
        switch outputUnit {
        case 0:
            return convertedInputValue * 28.3495
        case 1:
            return convertedInputValue * 28.3495 / 1000
        default:
            break
        }
        return 0.0
    }
    
    var body: some View {
        NavigationView {
            // Just to be clear, mass and weight are different, but they can be treated as the same under constant gravitational conditions. So this is assuming gravity is the normal, Earthly, 9.8 m/s^2.
            
            Form {
                Text("(Assuming constant, Earthly (9.8m/s^2), acceleration due to gravity)")
                    
                Section (header: Text("Input")) {
                    if inputType {
                        HStack {
                            TextField("(Ounces)", text: $inputOunces)
                            TextField("(Pounds)", text: $inputPounds)
                            TextField("(Tons)", text: $inputTons)
                            
                        }
                    } else {
                        Picker("Input units", selection: $inputUnit) {
                            ForEach(0 ..< inputUnits.count) {
                                Text("\(self.inputUnits[$0])")
                            }
                        }
                        .pickerStyle(SegmentedPickerStyle())
                        TextField("Input amount (\(inputUnits[inputUnit]))", text: $input)
                    }

                    Button("Switch input method") {
                        if self.inputType == false {
                            self.inputType = true
                        } else {
                            self.inputType = false
                        }
                    }

                    
                }
                
                Section (header: Text("Output")) {
                    Picker("Output units", selection: $outputUnit) {
                        ForEach(0 ..< outputUnits.count) {
                            Text("\(self.outputUnits[$0])")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    Text("\(output, specifier: "%.2f") (\(outputUnits[outputUnit]))")
                }
            }
        .navigationBarTitle(Text("Weight Conversion"))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
