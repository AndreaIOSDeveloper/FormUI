//
//  UIImage+.swift
//  FormUI
//
//  Created by Andrea Di Francia on 11/09/2020.
//  Copyright © 2020 Andrea Di Francia. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {
    func imageSnap(text: String? = nil, textAttributes: [NSAttributedString.Key : Any]?) -> UIImage? {
        let scale = Float(UIScreen.main.scale)
        var size = bounds.size
        
        if (contentMode == .scaleToFill ||
            contentMode == .scaleAspectFill ||
            contentMode == .scaleAspectFit ||
            contentMode == .redraw) {
            
            size.width = CGFloat(floorf((Float(size.width) * scale) / scale))
            size.height = CGFloat(floorf((Float(size.height) * scale) / scale))
        }
        
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        
        if let t = text {
            let attributes = textAttributes ?? [NSAttributedString.Key.foregroundColor: UIColor.white,
                                                NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15.0)]
            
            let textSize = t.size(withAttributes: attributes)
            let bounds = self.bounds
            
            t.draw(in: CGRect(x: bounds.size.width/2 - textSize.width/2, y: bounds.size.height/2 - textSize.height/2, width: textSize.width, height: textSize.height), withAttributes: attributes)
        }
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image
    }
    
    func profileImage(with name: String, fontType: UIFont = .boldSystemFont(ofSize: 12), fontSize: CGFloat = 16.0, borderColor: UIColor = UIColor.black, borderWidth: CGFloat = 1.0) {
        let _name = name.getInitialsUpperCase()
        
        self.layer.borderColor = borderColor.cgColor
        self.layer.borderWidth = borderWidth
        self.layer.cornerRadius = self.frame.size.height / 2
        self.layer.masksToBounds = true
        self.backgroundColor = .white
        
        //        if DataManager.sharedInstance.profile?.pictureProfile == nil {
        self.image = imageSnap(text: _name,
                               textAttributes: [NSAttributedString.Key.foregroundColor: UIColor.black,
                                                NSAttributedString.Key.font: fontType])
        self.clipsToBounds = true
    }
}
