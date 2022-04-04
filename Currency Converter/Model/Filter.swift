//
//  Filter.swift
//  Currency Converter
//
//  Created by Xiaoyu Liang on 2022-04-01.
//

import Foundation

func filter(originalList: [ConvertItem], using term: String) -> [ConvertItem] {
    
    // User is not searching...
    if term.isEmpty {
        
        // ...so return the original list
        return originalList
        
    } else {
        return originalList.filter { $0.contains(term: term) }
    }
    
}
