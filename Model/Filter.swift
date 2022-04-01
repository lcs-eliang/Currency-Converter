//
//  Filter.swift
//  Currency Converter
//
//  Created by Xiaoyu Liang on 2022-04-01.
//

import Foundation

func filter(originalList: [String], using term: String) -> [String] {
    
    // User is not searching...
    if term.isEmpty {
        
        // ...so return the original list
        return originalList
        
    } else {
        
        // Return the filtered list
        
        // TODO: Delete lines 51 to 53 and replace with appropriate logic
        let temporaryList: [String] = ["Pistachio"]
        return temporaryList
    }
    
}
