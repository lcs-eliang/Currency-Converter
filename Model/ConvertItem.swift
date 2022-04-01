//
//  FilterCurrency.swift
//  Currency Converter
//
//  Created by Xiaoyu Liang on 2022-03-28.
//

import Foundation

struct ConvertItem: Codable, Identifiable {
    var id: Int = 0
    var from: String = ""
    var to: String = ""
    var fromValue: String = ""
    var toValue: String = ""
  
}
