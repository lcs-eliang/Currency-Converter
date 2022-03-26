//
//  CurrencyData.swift
//  Currency Converter
//
//  Created by Xiaoyu Liang on 2022-03-13.
//

import Foundation

struct CurrencyData: Codable {
    var success: Bool
    var base = String("USD")
    var date: String
    var rates = [String: Double]()
}

func apiRequest(url: String, completion: @escaping (CurrencyData) -> ()) {
    let urlO = URL(string:url)!
    var request = URLRequest(url: urlO)
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    request.httpMethod = "GET"
    
    URLSession.shared.dataTask(with: request) { data, response, error in
        
        guard let data = data, error == nil else {
            print("An error occurs")
            return
        }
        if let curData = try? JSONDecoder().decode(CurrencyData.self, from: data) {
            completion(curData)
        } else {
            
            print("Invalid response from server.")
        }
        
    }.resume()
}
