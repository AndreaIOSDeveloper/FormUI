//
//  CustomSwitch.swift
//  FormUI
//
//  Created by Andrea Di Francia on 16/09/2020.
//  Copyright © 2020 Andrea Di Francia. All rights reserved.
//

import Foundation
import UIKit

class CustomSwitch: NibView {
    @IBOutlet private weak var cellTextSwitch: UILabel!
    @IBOutlet private weak var buttonSwitch: SwitchButton!
    
    public override func awakeFromNib() {
        super.awakeFromNib()
        cellTextSwitch.text = "*Inserisci testoInserisci testoInserisci testoInserisci testo"
    }
}
