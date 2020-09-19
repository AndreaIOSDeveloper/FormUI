//
//  String+.swift
//  FormUI
//
//  Created by Andrea Di Francia on 30/08/2020.
//  Copyright © 2020 Andrea Di Francia. All rights reserved.
//

import Foundation
import UIKit

extension String {
    var localized: String {
        return NSLocalizedString(self, tableName: nil, bundle: Bundle.main, value: "", comment: "")
    }
    
    var stringWithoutWhitespaces: String {
        return self.replacingOccurrences(of: " ", with: "")
    }
    
    func getInitialsUpperCase() -> String {
        let trimmedString = self.trimmingCharacters(in: .whitespacesAndNewlines)
        let components =  trimmedString.components(separatedBy: .whitespacesAndNewlines)
        
        if components.count == 1 {
            let string = trimmedString.components(separatedBy: .whitespacesAndNewlines).first?.uppercased()
            if let firstChar = string?.first {
                return ("\(firstChar)")
            }
        } else {
            let firstWord = trimmedString.components(separatedBy: .whitespacesAndNewlines).first?.uppercased()
            let lastWord = trimmedString.components(separatedBy: .whitespacesAndNewlines).last?.uppercased()
            
            if let firstChar1 = firstWord?.first, let firstChar2 = lastWord?.first {
                return ("\(firstChar1)\(firstChar2)")
            }
        }
        
        return self
    }
}
