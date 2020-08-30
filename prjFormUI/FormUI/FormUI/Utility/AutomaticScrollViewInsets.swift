//
//  AutomaticScrollViewInsets.swift
//  FormUI
//
//  Created by Andrea Di Francia on 29/08/2020.
//  Copyright © 2020 Andrea Di Francia. All rights reserved.
//

import UIKit

public protocol AutomaticScrollViewInsets: class {
    var bottomPadding: CGFloat { get }
    var autoInsetsNotificationTokens: [NSObjectProtocol] { get set }
}

extension AutomaticScrollViewInsets {
    public func setupAutoInsets(in scrollView: UIScrollView) {
        let originalBottomInset = scrollView.contentInset.bottom
        
        let keyboardWillChangeFrame = NotificationCenter.default.addObserver(
            forName: UIResponder.keyboardWillChangeFrameNotification,
            object: nil,
            queue: .main) { [weak self] notification in
                guard let self = self, let frame = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }
                let duration = (notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue ?? 0.3
                let option = (notification.userInfo?[UIResponder.keyboardAnimationCurveUserInfoKey] as? NSNumber)?.uintValue
                let height = frame.origin.y < UIScreen.main.bounds.height ? max(0, frame.height - scrollView.spaceFromDeviceBottom + self.bottomPadding) : originalBottomInset
                UIView.animate(
                    withDuration: duration,
                    delay: 0,
                    options: option != nil ? UIView.AnimationOptions(rawValue: option!) : .curveEaseInOut,
                    animations: {
                        scrollView.contentInset.bottom = height
                }, completion: nil)
        }
        
        autoInsetsNotificationTokens.append(keyboardWillChangeFrame)
    }
    
    public func disableAutoInsets() {
        autoInsetsNotificationTokens.forEach { NotificationCenter.default.removeObserver($0) }
        autoInsetsNotificationTokens = []
    }
}

public protocol AutomatizationKeyboardScroll: AutomaticScrollViewInsets { }

extension AutomatizationKeyboardScroll {
    public func setupNotifications(in scrollView: UIScrollView) {
        let noticationTextViewToken = NotificationCenter.default.addObserver(
            forName: UITextView.textDidBeginEditingNotification,
            object: nil,
            queue: .main) { [weak self] notification in
                guard let textView = notification.object as? UITextView else { return }
                self?.scroll(sourceView: textView, in: scrollView)
        }
        
        let noticationTextFieldToken = NotificationCenter.default.addObserver(
            forName: UITextField.textDidBeginEditingNotification,
            object: nil,
            queue: .main) { [weak self] notification in
                guard let textField = notification.object as? UITextField else { return }
                self?.scroll(sourceView: textField, in: scrollView)
        }
        
        [noticationTextViewToken, noticationTextFieldToken].forEach {
            autoInsetsNotificationTokens.append($0)
        }
    }
    
    private func scroll(sourceView: UIView, in scrollView: UIScrollView) {
        let convertedFrame = sourceView.convert(sourceView.bounds, to: scrollView)
        scrollView.scrollRectToVisible(convertedFrame, animated: true)
    }
}

