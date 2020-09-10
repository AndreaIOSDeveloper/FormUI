//
//  CustomTextField.swift
//  FormUI
//
//  Created by Andrea Di Francia on 30/04/2020.
//  Copyright © 2020 Andrea Di Francia. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable
public class CustomTextField: NibView {
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var textField: InsettableTextField!
    @IBOutlet private weak var separatorTopLeft: UIView!
    @IBOutlet private weak var separatorTopRight: UIView!
    @IBOutlet private weak var separatorBottom: UIView!
    @IBOutlet private weak var sepratorRight: UIView!
    @IBOutlet private weak var separatorLeft: UIView!
    @IBOutlet private weak var passwordButton: UIButton!
    @IBOutlet private var topTitleContraint: NSLayoutConstraint!
    @IBOutlet private var downTitleContraint: NSLayoutConstraint!
    
    private var titleColor: UIColor?
    private var titlePlaceholder: String = ""
    private var isPassword: Bool = false

    public override func awakeFromNib() {
        super.awakeFromNib()
        setup()
        
        textField.delegate = self
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        topTitleContraint.isActive = false
        downTitleContraint.isActive = true
    }
    
    private func setup() {
        setBorder(hidden: true)
        configureUI()
    }
    
    private func configureUI() {
        passwordButton.isHidden = !isPassword
        textField.isSecureTextEntry = isPassword
        titleLabel.textColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
    }
    
    func setBorder(hidden: Bool) {
        [separatorTopLeft, separatorTopRight, sepratorRight, separatorLeft].forEach {
            $0?.isHidden = hidden
        }
    }
    
    public func setBorder(color: UIColor, titleColor: UIColor? = nil) {
        [separatorTopLeft, separatorTopRight, separatorBottom, sepratorRight, separatorLeft].forEach {
            $0?.backgroundColor = color
        }
        
        self.titleColor = (titleColor == nil ? color : titleColor)
    }
    
    public func seTitle(title: String, placeholder: String? = nil, isPassword: Bool = false) {
        titleLabel.text = title
        titlePlaceholder = ((placeholder != nil) ? placeholder : title) ?? ""
        self.isPassword = isPassword
        
        configureUI()
    }
    
    func assetsImage(with name: String) -> UIImage {
        return UIImage(named: name, in: Bundle.bundleFormUI, compatibleWith: nil) ?? UIImage()
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        setBorder(hidden: false)
        
        UIView.animate(withDuration: 1, delay: 0, options: .curveEaseIn, animations: {
            self.titleLabel.textColor = self.titleColor
            self.topTitleContraint.isActive = true
            self.downTitleContraint.isActive = false
        }) { _ in
            //completed 
        }
        
        textField.placeholder = textField.text?.count == 0 ? titlePlaceholder : ""
    }
    
    @IBAction private func showPasswordDIdTap(_ sender: Any) {
        isPassword.toggle()
        passwordButton.setImage(isPassword ? assetsImage(with: "eye_open") : assetsImage(with:"eye_close"), for: .normal)
        textField.isSecureTextEntry = isPassword
    }
}

// MARK: UITextFieldDelegate

extension CustomTextField: UITextFieldDelegate {
    public func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        textField.placeholder = ""
        
        if textField.text?.count == 0 {
            setBorder(hidden: true)
            topTitleContraint.isActive = false
            downTitleContraint.isActive = true
            titleLabel.textColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        }
    }
}
