//
//  ContentView.swift
//  Currency Converter
//
//  Created by Xiaoyu Liang on 2022-03-11.
//

import SwiftUI

struct ContentView: View {
    @State private var rate:String = "Loading"
    @State private var currencyType:String = "LSL"
    var body: some View {
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
