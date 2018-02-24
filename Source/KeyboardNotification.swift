//
//  KeyboardNotification.swift
//  KeyboardNotification
//
//  Created by Manish Bhande on 24/02/18.
//  Copyright © 2018 Manish Bhande. All rights reserved.
//

import Foundation
import UIKit

public protocol KeyboardNotification: class {
    
    func registerKeyboardNotification()
    func deregisterKeyboardNotification()
    
    var keyboardTokens: [NSObjectProtocol]? { get set }
    
    func willShowKeyboard(_ note: Notification)
    func didShowKeyboard(_ note: Notification)
    func willHideKeyboard(_ note: Notification)
    func didHideKeyboard(_ note: Notification)
    func willChangeKeyboardFrame(_ note: Notification)
    func didChangeKeyboardFrame(_ note: Notification)
    
}

public extension KeyboardNotification {
    
    func registerKeyboardNotification() {
        deregisterKeyboardNotification()
        keyboardTokens = []
        allNotificationName.forEach {
            keyboardTokens?.append(NotificationCenter.default.addObserver(forName: $0, object: nil, queue: nil) { [weak self] in
                self?.handleNotification($0)
            })
        }
    }
    
    func deregisterKeyboardNotification() {
        keyboardTokens?.forEach {
            NotificationCenter.default.removeObserver($0, name: nil, object: nil)
        }
        keyboardTokens?.removeAll()
        keyboardTokens = nil
    }
    
    private var allNotificationName: [Notification.Name] {
        
        return [Notification.Name.UIKeyboardWillShow,
                Notification.Name.UIKeyboardDidShow,
                Notification.Name.UIKeyboardWillHide,
                Notification.Name.UIKeyboardDidHide,
                Notification.Name.UIKeyboardWillChangeFrame,
                Notification.Name.UIKeyboardDidChangeFrame]
    }
    
    private func handleNotification(_ note: Notification) {
        
        switch note.name {
        case NSNotification.Name.UIKeyboardWillShow: willShowKeyboard(note)
        case NSNotification.Name.UIKeyboardDidShow: didShowKeyboard(note)
        case NSNotification.Name.UIKeyboardWillHide: willHideKeyboard(note)
        case NSNotification.Name.UIKeyboardDidHide: didHideKeyboard(note)
        case NSNotification.Name.UIKeyboardWillChangeFrame: willChangeKeyboardFrame(note)
        case NSNotification.Name.UIKeyboardDidChangeFrame: didChangeKeyboardFrame(note)
        default: break
        }
        
    }
    
}

public extension Notification {
    
    public var keyboardFrame: CGRect? { return self.userInfo?[UIKeyboardFrameEndUserInfoKey] as? CGRect }
    public var keyboardSize: CGSize? { return self.keyboardFrame?.size }
    
}
