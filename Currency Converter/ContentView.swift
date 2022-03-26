//
//  ContentView.swift
//  Currency Converter
//
//  Created by Xiaoyu Liang on 2022-03-11.
//

import SwiftUI

struct ContentView: View {
    
    @State private var inputCurrency: String = ""
    @State private var outputCurrency: String = ""
    @State private var rate: String = ""
    @State private var inputAmount = ""
    @State private var select1 = CurrencySelection.all
    @State private var select2 = CurrencySelection.all

    
    var body: some View {
        NavigationView {
            Form {
               
                Section {
                        
                    Picker(selection: $select1, label: Text("From")) {
                        ForEach(CurrencySelection.allCases, id: \.self) { currency in
                            Text(currency.rawValue)
                                
                        }
                    }
                        
                    Picker(selection: $select2, label: Text("To")) {
                        ForEach(CurrencySelection.allCases, id: \.self) { currency in
                            Text(currency.rawValue)
                                
                        }
                    }
                        
                   
                        
                    }
                
                Section {
                    TextField("Type the amount to be converted here", text: $inputAmount)
                        .keyboardType(.decimalPad)
                    
                    Text(rate+" \(select2.id)")
                    
                }
                
                Section {
                    Button(action: {
                        apiRequest(url: "https://api.exchangerate.host/latest?base=\(select1.id)&amount=\(inputAmount)") {currencyData in

                            for (key, value) in currencyData.rates {
                                if key == select2.id {
                                    rate = String(value)
                                    break
                                }
//                                    print("\(key) -> \(value)")
                            }
                            print(currencyData)
                            
                        }
                    }, label: {
                        Text("CONVERT")
                            .font(.headline)
                            .multilineTextAlignment(.center)
                    })
                }
                
                }.navigationBarTitle("Currency Converter")
        }
     
        }
    
    }



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
