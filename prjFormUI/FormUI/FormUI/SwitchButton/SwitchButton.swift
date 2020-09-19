//
//  SwitchButton.swift
//  FormUI
//
//  Created by Andrea Di Francia on 16/09/2020.
//  Copyright © 2020 Andrea Di Francia. All rights reserved.
//

import Foundation
import UIKit

class SwitchButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addTarget(self, action: #selector(self.touch), for: .touchUpInside)
        
        self.setImage(assetsImage(with: "on"), for: .selected)
        self.setImage(assetsImage(with: "off"), for: .normal)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        self.addTarget(self, action: #selector(self.touch), for: .touchUpInside)
        
        self.setImage(assetsImage(with: "on"), for: .selected)
        self.setImage(assetsImage(with: "off"), for: .normal)
    }
    
    @IBAction func touch(sender: UIButton) {
        self.isSelected = !self.isSelected
    }
    
    override var isSelected: Bool {
        didSet {
            // self.setImage(UIImage.init(named: self.isSelected ? "on" : "off"), for: .disabled)
            self.setImage(assetsImage(with: self.isSelected ? "on" : "off"), for: .normal)
        }
    }
    
    func assetsImage(with name: String) -> UIImage {
        return UIImage(named: name, in: Bundle.bundleFormUI, compatibleWith: nil) ?? UIImage()
    }
}
