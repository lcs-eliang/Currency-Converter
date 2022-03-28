//
//  NetworkManager.swift
//  Currency Converter
//
//  Created by Xiaoyu Liang on 2022-03-28.
//

import SwiftUI

class NetworkManager:ObservableObject {

    @Published var currencyCode: [String] = []
    @Published var exchangePrice: [Double] = []

//    init() {
//        fetchCurrencyData { (currency) in
//            switch currency {
//            case .success(let prices):
//                self.currencyCode.append(contentsOf: prices.rates.keys)
//                self.exchangePrice.append(contentsOf: prices.rates.values)
//            }
//        }
//    }
//}
    func fetchCurrencyData() {

        // 1. Prepare a URLRequest to send our encoded data as JSON
        let url = URL(string: "http://open.exchangerate-api.com/v6/latest")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "GET"

        // 2. Run the request and process the response
        URLSession.shared.dataTask(with: request) { data, response, error in

            // handle the result here – attempt to unwrap optional data provided by task
            guard let safeData = data else {

                // Show the error message
                print("No data in response: \(error?.localizedDescription ?? "Unknown error")")

                return
            }

            // It seems to have worked? Let's see what we have
            print(String(data: safeData, encoding: .utf8)!)

            // Now decode from JSON into an array of Swift native data types
            if let currency = try? JSONDecoder().decode(CurrencyData.self, from: safeData) {

                print("Currency data decoded from JSON successfully")
                print("Text is: \(currency)")

            } else {

                print("Invalid response from server.")
            }

        }.resume()

    }
}
