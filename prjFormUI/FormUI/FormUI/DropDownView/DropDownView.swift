//
//  DropDownView.swift
//  FormUI
//
//  Created by Andrea Di Francia on 01/05/2020.
//  Copyright © 2020 Andrea Di Francia. All rights reserved.
//

import Foundation
import UIKit

public protocol DropDownViewDelegate: class {
    func dropDownDidPress(currentDropDown: DropDownView, textDidSelected text: String)
}

public class DropDownView: NibView {
    @IBOutlet private weak var arrowButton: UIButton!
    @IBOutlet private weak var stackView: UIStackView!
    @IBOutlet private weak var titleLable: UILabel!
    
    private let tableViewController = SearchTableViewController()
    private var delegateSearchTableView: SearchTableViewControllerDelegate?
    private var isDropdownStateTouch = false
    private var textTitleColor: UIColor? = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    private weak var delegateDropDownView: DropDownViewDelegate?
    
    public var elements: [String] = []
    public var delegate = UIViewController()
    
    public override func awakeFromNib() {
        super.awakeFromNib()
        configureDropDownView()
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(self.someAction (_:)))
        self.addGestureRecognizer(gesture)
        
        tableViewController.delegate = self
        delegateSearchTableView = tableViewController.delegate
    }
    
    // MARK: - Private
    private func presentPopover() {
        tableViewController.delegate = delegateSearchTableView
        tableViewController.elements = elements
        
        tableViewController.modalPresentationStyle = UIModalPresentationStyle.popover
        tableViewController.preferredContentSize = CGSize(width: 400, height: 400)
        
        let popoverPresentationController = tableViewController.popoverPresentationController
            popoverPresentationController?.sourceView = self
            popoverPresentationController?.sourceRect = CGRect(x: 0,
                                                           y: 0,
                                                           width: self.frame.size.width,
                                                           height: self.frame.size.height)
        
        delegate.present(tableViewController, animated: true)
    }
    
    private func change(title: String) {
        titleLable.textColor = textTitleColor
        titleLable.text = title
    }
    
    // MARK: - IBAction
    @IBAction private func arrowButtonDidPress(_ sender: Any) {
        isDropdownStateTouch.toggle()
        arrowButton.transform = arrowButton.transform.rotated(by: .pi)
        presentPopover()
    }
    
    @objc private func someAction(_ sender:UITapGestureRecognizer) {
        isDropdownStateTouch.toggle()
        arrowButton.transform = arrowButton.transform.rotated(by: .pi)
        presentPopover()
    }
    
    // MARK: - Public func
    
    ///     Configure title and color and other of dropDownView
    ///
    /// - Parameter placeholderTitle for set the title on screen
    public func configureDropDownView(with placeholderTitle: String = "Placeholder", placeholdertTextTitleColor: UIColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1), textTitleColor: UIColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), colorArrow: UIColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), dropDownBorderColor: UIColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)) {
        titleLable.text = placeholderTitle
        
        self.textTitleColor = textTitleColor
        titleLable.textColor = placeholdertTextTitleColor
        
        self.layer.borderWidth = 1
        self.layer.borderColor = dropDownBorderColor.cgColor
        arrowButton.tintColor = colorArrow
    }
}

// MARK: - SearchTableViewControllerDelegate

extension DropDownView: SearchTableViewControllerDelegate {
    public func searchDidComplete(with elem: String) {
        DispatchQueue.main.async { [weak self] in
            self?.change(title: elem)
            self?.delegateDropDownView?.dropDownDidPress(currentDropDown: self!, textDidSelected: elem)
            self?.arrowButton.transform = self?.arrowButton.transform.rotated(by: .pi) ?? CGAffineTransform(rotationAngle: 0)
            self?.delegate.dismiss(animated: true)
        }
    }
}
