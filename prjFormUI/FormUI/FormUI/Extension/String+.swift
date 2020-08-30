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
}
