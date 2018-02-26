//
//  KeyboardNotification.swift
//  KeyboardNotification
//
//  Created by Manish Bhande on 24/02/18.
//  Copyright © 2018 Manish Bhande. All rights reserved.
//

import Foundation
import UIKit

/// Get all keyboard show/hide notification
public protocol KeyboardNotification: class {
    
    /// Register object for keyboard notification
    func registerKeyboardNotification()
    
    /// Deregister object for keyboard notification
    func deregisterKeyboardNotification()
    
    /// Keyboard notification token holder
    var keyboardTokens: [NSObjectProtocol]? { get set }
    
    /// Callback, when keyboard is about to show
    ///
    /// - Parameter note: Notification object of Keyboard
    func willShowKeyboard(_ note: Notification)
    
    /// Callback, when keyboard is displayed on window
    ///
    /// - Parameter note: Notification object of Keyboard
    func didShowKeyboard(_ note: Notification)
    
    /// Callback, when keyboard is about to hide
    ///
    /// - Parameter note: Notification object of Keyboard
    func willHideKeyboard(_ note: Notification)
    
    /// Callback, when keyboard is hidden from window
    ///
    /// - Parameter note: Notification object of Keyboard
    func didHideKeyboard(_ note: Notification)
    
    /// Callback, when keyboard frame is about ot change
    ///
    /// - Parameter note: Notification object of Keyboard
    func willChangeKeyboardFrame(_ note: Notification)
    
    /// Callback, when keyboard frame is changed
    ///
    /// - Parameter note: Notification object of Keyboard
    func didChangeKeyboardFrame(_ note: Notification)
    
}


// MARK: - handling default implentation

public extension KeyboardNotification {
    
    /// Register object for all keyboard event store it on token for future use
    func registerKeyboardNotification() {
        deregisterKeyboardNotification()
        keyboardTokens = []
        allNotificationName.forEach {
            keyboardTokens?.append(NotificationCenter.default.addObserver(forName: $0,
                                                                          object: nil,
                                                                          queue: nil,
                                                                          using: handleNotification))
        }
    }
    
    /// Deregister object for all keyboard notification saved as token
    func deregisterKeyboardNotification() {
        keyboardTokens?.forEach {
            NotificationCenter.default.removeObserver($0, name: nil, object: nil)
        }
        keyboardTokens?.removeAll()
        keyboardTokens = nil
    }
    
    /// All notification thet need to handle
    private var allNotificationName: [Notification.Name] {
        
        return [Notification.Name.UIKeyboardWillShow,
                Notification.Name.UIKeyboardDidShow,
                Notification.Name.UIKeyboardWillHide,
                Notification.Name.UIKeyboardDidHide,
                Notification.Name.UIKeyboardWillChangeFrame,
                Notification.Name.UIKeyboardDidChangeFrame]
    }
    
    /// map notification and callback method
    ///
    /// - Parameter note: Notification of keyboard
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

// MARK: - Keyboard frame accessor
public extension Notification {
    
    /// Get keyboard frame from Notification object
    public var keyboardFrame: CGRect? {
        return self.userInfo?[UIKeyboardFrameEndUserInfoKey] as? CGRect
    }
    
    /// Get keyboard size from Notification object
    public var keyboardSize: CGSize? {
        return self.keyboardFrame?.size
    }
    
}
