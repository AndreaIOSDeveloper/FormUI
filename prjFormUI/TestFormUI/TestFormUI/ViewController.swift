//
//  ViewController.swift
//  TestFormUI
//
//  Created by Andrea Di Francia on 29/08/2020.
//  Copyright © 2020 Andrea Di Francia. All rights reserved.
//

import UIKit
import FormUI

class ViewController: UIViewController, AutomaticScrollViewInsets {
    @IBOutlet private weak var content: UIView!
    @IBOutlet private weak var test: CustomTextField!
    @IBOutlet private weak var test2: CustomTextField!
    @IBOutlet private weak var testDropView: DropDownView!
    
    // MARK: - AutomaticScrollViewInsets
    public let bottomPadding: CGFloat = 20
    public var autoInsetsNotificationTokens: [NSObjectProtocol] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        test.seTitle(title: "Nickname", isPassword: false)
        test.setBorder(color: #colorLiteral(red: 0.9981608987, green: 0.4063819647, blue: 0.003763247048, alpha: 1))
        
        test2.seTitle(title: "Password", isPassword: true)
        test2.setBorder(color: #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1))

        testDropView.delegate = self
        testDropView.datasource = self
        //testDropView.configureDropDownView(with: "placeholder", textTitleColor: #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1), colorArrow: #colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1), dropDownBorderColor: #colorLiteral(red: 0.7254902124, green: 0.4784313738, blue: 0.09803921729, alpha: 1))

        // TODO: Inserirla da codice
        //  let example = CustomTextField()
        //  example.seTitle(title: "Andrea", isPassword: true)
        //  example.setBorder(color: #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1))
        //  content.addSubview(example)

        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}


extension ViewController: DropDownViewDelegate, DropDownViewDataSource {    
    func dropDown(_ dropDown: DropDownView) -> [String] {
        return ["a","b"]
    }
    
    func dropDownDidPress(_ dropDown: DropDownView, textDidSelected text: String) {
        print("dropDownDidPress: "+text)
    }
}
