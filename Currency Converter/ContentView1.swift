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
            
            TabView {
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
                            
                        }.onTapGesture {
                            hideKeyboard()
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
                        
                        
                    }
                }.navigationTitle("Currency Converter")
            }.tabItem {
                        Label("Converter", systemImage: "arrow.left.arrow.right")
                            .font(.headline)
                    }
            
                TabView {
                    NavigationView {
            
                    List(filter(originalList: saveList, using: searchTerm), id: \.self) { item in
                        
                        Text(item.toString())
                        
                    }.searchable(text: $searchTerm)
                    }.navigationTitle("History")
                }.tabItem {
                        Label("History", systemImage: "clock")
                        Text("History")
                    }
                        
                    }
                
                
                
            }
        }
        
        
        extension View {
            func hideKeyboard() {
                let resign = #selector(UIResponder.resignFirstResponder)
                UIApplication.shared.sendAction(resign, to: nil, from: nil, for: nil)
            }
        }
        
        
        
        struct ContentView1_Previews: PreviewProvider {
            static var previews: some View {
                ContentView1()
            }
        }
        
