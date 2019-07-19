//
//  KeyboardNotification.swift
//  KeyboardNotification
//
//  Created by Manish Bhande on 24/02/18.
//  Copyright © 2018 Manish Bhande. All rights reserved.
//

import Foundation
import UIKit


public extension Notification {
    
    /// Notification block handler send by NotificationCenter
    typealias KeyboardHandler = (_ note: Notification) -> Void
    
    /// Keyboard notfication types
    enum Keyboard {
        
        case willShow
        case didShow
        case willHide
        case didHide
        case willChangeFrame
        case didChangeFrame
        
        /// Get the Notification.Name
        public var name: Name {
            switch self {
            case .willShow: return UIResponder.keyboardWillShowNotification
            case .didShow: return UIResponder.keyboardDidShowNotification
            case .willHide: return UIResponder.keyboardWillHideNotification
            case .didHide: return UIResponder.keyboardDidHideNotification
            case .willChangeFrame: return UIResponder.keyboardWillChangeFrameNotification
            case .didChangeFrame: return UIResponder.keyboardDidChangeFrameNotification
            }
        }
        
        // Get all the available KeyboardNotification Type
        public static var all: [Keyboard] {
            return [willShow, willHide, willChangeFrame, didHide, didShow, didChangeFrame]
        }
    }
    
}

/// Manage all the keyboard Notification
public protocol KeyboardNotification: class {
    
    typealias NotificationRegistration = (Notification.Keyboard, Notification.KeyboardHandler)
    
    /// Returns a object which can use for deregistering keyboard notification
    ///
    /// Register your object for a notification
    /// - Parameter note: Keyboard notification type
    /// - Parameter handler: Notification handler
    ///
    @discardableResult
    func registerKeyboardNotification(_ note: Notification.Keyboard, handler: @escaping Notification.KeyboardHandler) -> NSObjectProtocol
    
    /// Returns list of keyboard notification and objects which can use for deregistering keyboard notification
    ///
    /// Register mulitple notifications for object
    /// - Parameter notes: Keyboard notification and Handler
    @discardableResult
    func registerKeyboardNotification(for notes: [NotificationRegistration]) -> [(Notification.Keyboard, NSObjectProtocol)]
    
    /// Remove keyboard notification  for given type
    /// - Parameter observer: Object to notification observer
    /// - Parameter type: Keyboard notification to remove
    func deregisterKeyboardNotification(_ observer: NSObjectProtocol, type: Notification.Keyboard)
    
    /// Remove all the notification from list
    /// - Parameter notes: Keyboard notificatio and Observer object
    func deregisterKeyboardNotification(_ notes: [(Notification.Keyboard, NSObjectProtocol)])
    
}


// MARK: - Default implementation
public extension KeyboardNotification {
    
    @discardableResult
    func registerKeyboardNotification(_ note: Notification.Keyboard, handler: @escaping Notification.KeyboardHandler) -> NSObjectProtocol {
        return NotificationCenter.default.addObserver(forName: note.name, object: nil, queue: nil, using: handler)
    }
    
    @discardableResult
    func registerKeyboardNotification(for notes: [NotificationRegistration]) -> [(Notification.Keyboard, NSObjectProtocol)] {
        return notes.map { ($0.0,registerKeyboardNotification($0.0, handler: $0.1)) }
    }
    
    func deregisterKeyboardNotification(_ observer: NSObjectProtocol, type: Notification.Keyboard) {
        NotificationCenter.default.removeObserver(observer, name: type.name, object: nil)
    }
    
    func deregisterKeyboardNotification(_ notes: [(Notification.Keyboard, NSObjectProtocol)]) {
        notes.forEach { deregisterKeyboardNotification($0.1, type: $0.0) }
    }
    
}

// MARK: - Keyboard frame accessor
public extension Notification {
    
    /// Get keyboardfrom Notification object
    var keyboardFrame: CGRect? {
        return self.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect
    }
    
    /// Get keyboard size from Notification object
    var keyboardSize: CGSize? {
        return self.keyboardFrame?.size
    }
    
}

