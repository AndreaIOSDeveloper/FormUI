//
//  InsettableLabel.swift
//  FormUI
//
//  Created by Andrea Di Francia on 30/08/2020.
//  Copyright © 2020 Andrea Di Francia. All rights reserved.
//

import UIKit

open class InsettableLabel: UILabel {
    public var textInsets: UIEdgeInsets = .zero {
        didSet { setNeedsLayout() }
    }
    
    open override func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: textInsets))
    }
    
    open override var intrinsicContentSize: CGSize {
        return super.intrinsicContentSize.insettedSize(insets: textInsets)
    }
}

private extension CGSize {
    func insettedSize(insets: UIEdgeInsets) -> CGSize {
        return CGSize(
            width: width + insets.left + insets.right,
            height: height + insets.top + insets.bottom)
    }
}

