//
//  FilterCurrency.swift
//  Currency Converter
//
//  Created by Xiaoyu Liang on 2022-03-28.
//

import Foundation

func filter(originalList: [String], using term: String) -> [String] {
    
    if term.isEmpty {
        
        return originalList
        
    } else {
        
        return originalList.filter { $0.contains(term) }
        
    }
    
}
