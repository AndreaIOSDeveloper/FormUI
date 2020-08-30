//
//  UITextField+.swift
//  FormUI
//
//  Created by Andrea Di Francia on 29/08/2020.
//  Copyright © 2020 Andrea Di Francia. All rights reserved.
//

import UIKit

/// A subclass to setup custom text insets
public class InsettableTextField: UITextField {
    public var textInsets: UIEdgeInsets = .zero {
        didSet { setNeedsLayout() }
    }
    
    public var leftViewInsets: UIEdgeInsets = .zero {
        didSet { setNeedsLayout() }
    }
    
    public var rightViewInsets: UIEdgeInsets = .zero {
        didSet { setNeedsLayout() }
    }
    
    open override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        super.textRect(forBounds: bounds).inset(by: textInsets)
    }
    
    open override func editingRect(forBounds bounds: CGRect) -> CGRect {
        super.editingRect(forBounds: bounds).inset(by: textInsets)
    }
    
    open override func textRect(forBounds bounds: CGRect) -> CGRect {
        super.textRect(forBounds: bounds).inset(by: textInsets)
    }
    
    open override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
        super.leftViewRect(forBounds: bounds).inset(by: leftViewInsets)
    }
    
    open override func rightViewRect(forBounds bounds: CGRect) -> CGRect {
        super.rightViewRect(forBounds: bounds).inset(by: rightViewInsets)
    }
}

