//
//  ContentView.swift
//  Currency Converter
//
//  Created by Xiaoyu Liang on 2022-03-11.
//

import SwiftUI

struct ContentView: View {
    
    @State private var inputCurrency = 0
    @State private var outputCurrency = 1
    @State private var rate: String = ""
    @State private var currencyType: String = ""
    @State private var inputAmount = ""
    @State private var selectCurrencySelection = CurrencySelection.all
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Currency Converter")
                    .font(.title)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.leading)
                    
                Form {
                    Section {
                        TextField("Type the amount to be converted here", text: $inputAmount)
                                .keyboardType(.decimalPad)
                        }
                    
                    Section {
                        
                        Picker(selection: $selectCurrencySelection, label: Text("From")) {
                            ForEach(CurrencySelection.allCases, id: \.self) { currency in
                                Text(currency.rawValue)
                                
                            }.pickerStyle(.wheel)
                        }
                        
                        Picker(selection: $selectCurrencySelection, label: Text("To")) {
                            ForEach(CurrencySelection.allCases, id: \.self) { currency in
                                Text(currency.rawValue)
                                
                            }.pickerStyle(.wheel)
                        }
                        
                    Section {
                        Button(action: {
                           
                        }, label: {
                            Text("CONVERT")
                                .font(.headline)
                                .multilineTextAlignment(.center)
                        })
                    }
                        
                    }
                }
            }
        }
     
            Text("USD:"+currencyType+"= 100:"+rate)
                .padding().onAppear {
                    apiRequest(url: "https://api.exchangerate.host/latest?base=USD&amount=100") {currencyData in
                        for (key, value) in currencyData.rates {
                            if key == currencyType {
                                rate = String(value)
                                break
                            }
                            print("\(key) -> \(value)")
                        }
                        //print(currencyData)
                        
                        }
                }
        }
    
    }



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
