//
//  Extensions.swift
//  NeoSim
//
//  Created by Karen Mirakyan on 23.04.24.
//

import Foundation
extension Int {
    
    var numberString: String {
        
        guard self < 10 else { return "0" }
        
        return String(self)
    }
}

extension String {
    
    var digits: [Int] {
        var result = [Int]()
        
        for char in self {
            if let number = Int(String(char)) {
                result.append(number)
            }
        }
        return result
    }
}
