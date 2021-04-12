//
//  ContentView.swift
//  Shared
//
//  Created by Michael Gable on 4/8/21.
//

import SwiftUI

struct ContentView: View {
    let tipAmounts = [5,10,15,20,25,0]
    @State private var checkAmount = ""
    @State private var numberOfPeople = 0
    @State private var tipPercentage = 5
    var costPerPerson: Double {
        //calculate the cost per person
        let peopleCount = Double(numberOfPeople + 2)
        let tipSelection = Double(tipAmounts[tipPercentage])
        let orderAmount = Double(checkAmount) ?? 0
        
        let tipValue = orderAmount/100 * tipSelection
        let grandTotal = orderAmount + tipValue
        return grandTotal/peopleCount
    }
    
    var body: some View {
        
        NavigationView {
            Form {
                Section {
                    TextField("Amount", text: $checkAmount)
                        .keyboardType(.decimalPad)
                    
                    Picker("Number Of People", selection: $numberOfPeople) {
                        ForEach(2 ..< 100) {
                            Text("\($0) people")
                        }
                    }
                }
                
                Section(header: Text("How much of a tip would you like to add?")) {
                    Picker("Tip Percentage", selection: $tipPercentage) {
                        ForEach(0 ..< tipAmounts.count) {
                            Text("\(self.tipAmounts[$0])%")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                .textCase(nil)
                
                Section(header: Text("Amount per person")) {
                    Text("Check Amount: $\(costPerPerson, specifier: "%.2f")")
                }
                .textCase(nil)
            }
            .navigationBarTitle("WeSplit")
        }

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
