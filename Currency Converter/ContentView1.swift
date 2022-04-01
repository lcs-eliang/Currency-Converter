//
//  ContentView1.swift
//  Currency Converter
//
//  Created by Xiaoyu Liang on 2022-03-26.
//

import SwiftUI

struct ContentView1: View {
    
    @State private var rate: String = ""
    @State private var inputAmount = ""
    @State private var selected1 = 0
    @State private var selected2 = 1
    @State private var currencyList = ["USD"]
    @State private var searchTerm = ""
    @State private var saveList: [ConvertItem] = []
    
    
    var body: some View {
        
        if currencyList.count == 1 {
            Text("Loading...").onAppear(perform: {
                apiRequest(url: "https://api.exchangerate.host/latest?base=USD&amount=100") { currencyData in
                    
                    for (key, _) in currencyData.rates {
                        currencyList.append(key)
                    }
                    currencyList.sort()
                }
            })
            
        } else {
            
            NavigationView {
                Form {
                    Section {
                    
                        Picker(selection: $selected1, label: Text("From")) {
//                        List(filter(originalList: currencyList, using: searchTerm), id: \.self) { item in
//                                Text(item)
//                        }

                            ForEach(0..<currencyList.count, id: \.self) {
                            Text(currencyList[$0])
                            }
                        }
                    }
                        
                        
                        Picker(selection: $selected2, label: Text("To")) {
                            ForEach(0..<currencyList.count, id: \.self) {
                                Text(currencyList[$0])
                                
                            }
                        }
                    
                    
                        Section {
                        TextField("Type the amount to be converted here", text: $inputAmount)
                            .keyboardType(.decimalPad)
                        
                        Text(rate+" \(currencyList[selected2])")
                        
                    }
                    
                    Section {
                       
                            Button(action: {
                            apiRequest(url: "https://api.exchangerate.host/latest?base=\(currencyList[selected1])&amount=\(inputAmount)") {currencyData in
                                for (key, value) in currencyData.rates {
                                    if key == currencyList[selected2] {
                                        rate = String(value)
                                        break
                                    }
                                }
                                print(currencyData)
                                
                            }
                        }, label: {
                            Text("CONVERT")
                                .font(.headline)
                                .multilineTextAlignment(.center)
                        })
                            
                        
                        
                            Button(action: {
                            let item: ConvertItem = ConvertItem(from: currencyList[selected1],
                                                                to: currencyList[selected2],
                                                                fromValue: inputAmount,
                                                                toValue: rate)
                           
                            saveList.append(item)
                        }, label: {
                           Text("SAVE")
                                .font(.headline)
                        })
                        }
                    
                    
                    Section {
                        
                        List {
                                
                                Text("History Saved Convertions")
                                    .font(.title3)
                                
                                ForEach(0..<saveList.count, id: \.self) {
                                    Text("\(saveList[$0].fromValue) \(saveList[$0].from) = \(saveList[$0].toValue) \(saveList[$0].to)")
                                }

                          
                        }
                    }
                        
                }.navigationTitle("Currency Converter")
                    
                }
            }
        }
}
    




struct ContentView1_Previews: PreviewProvider {
    static var previews: some View {
        ContentView1()
    }
}

