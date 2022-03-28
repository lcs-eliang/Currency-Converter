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
                    List {
                        Section {
                        
                        Picker(selection: $selected1, label: Text("From")) {
                            List(filter(originalList: currencyList, using: searchTerm), id: \.self) { currencyList in
                                Text(currencyList)
                            }
                            .navigationTitle("Currencies")
                            .searchable(text: $searchTerm)
                            
                                ForEach(0..<currencyList.count, id: \.self) {
                                Text(currencyList[$0])
                                }
                            }
                            .searchable(text: $searchTerm)
                        }
                        
                        
                        Picker(selection: $selected2, label: Text("To")) {
                            ForEach(0..<currencyList.count, id: \.self) {
                                Text(currencyList[$0])
                                
                            }
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
                    }
                        
                    }
                    
                }.navigationBarTitle("Currency Converter")
            }
        }
    }
    




struct ContentView1_Previews: PreviewProvider {
    static var previews: some View {
        ContentView1()
    }
}

