//
//  KeyBoardNotification.swift
// 
//
//  Created by Manish on 1/18/17.
//  Copyright © 2017 Manish. All rights reserved.
//

import Foundation
import UIKit

public extension NSObject {
    
    func registerKeyBoardNotification() {
        KeyBoardNotificationRegister.manager.register(object: self, keepAlive: false)
    }
    
    func deregisterKeyBoardNotification() {
        KeyBoardNotificationRegister.manager.deregister(object: self)
    }
}

private protocol Observer {
    var value: NSObject? { get }
    func perform(selector: Selector, object: Notification)
}

private class WeakObserver: Observer {
    weak var value: NSObject?
    init (value: NSObject) {
        self.value = value
    }
    
    
    func perform(selector: Selector, object: Notification) {
        if self.value?.responds(to: selector) == true {
            _ = self.value?.perform(selector, with: object)
        }
    }
}

private class AliveObserver: Observer {
    var value: NSObject?
    init (value: NSObject) {
        self.value = value
    }
    func perform(selector: Selector, object: Notification) {
        if self.value?.responds(to: selector) == true {
            _ = self.value?.perform(selector, with: object)
        }
    }
}

fileprivate class KeyBoardNotificationRegister {
    
    fileprivate static let manager = KeyBoardNotificationRegister()
    private var observerObjects: [Observer] = []
    
    init() {
        NotificationCenter.default.addObserver(self, selector:  #selector(willShowKeyBoard), name:NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector:  #selector(didShowKeyBoard), name:NSNotification.Name.UIKeyboardDidShow, object: nil)
        NotificationCenter.default.addObserver(self, selector:  #selector(willHideKeyBoard), name:NSNotification.Name.UIKeyboardWillHide, object: nil)
        NotificationCenter.default.addObserver(self, selector:  #selector(didHideKeyBoard), name:NSNotification.Name.UIKeyboardDidHide, object: nil)
        NotificationCenter.default.addObserver(self, selector:  #selector(willChangeKeyBoardFrame), name:NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
        NotificationCenter.default.addObserver(self, selector:  #selector(didChangeKeyBoardFrame), name:NSNotification.Name.UIKeyboardDidChangeFrame, object: nil)
    }
    
    deinit {
        observerObjects.removeAll()
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardDidShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardDidShow, object: nil)
    }
    
    func register(object: NSObject, keepAlive: Bool) {
        self.deregister(object: object)
        self.observerObjects.append(keepAlive ? AliveObserver(value: object) : WeakObserver(value: object))
    }
    
    func deregister(object: NSObject) {
        guard let index = self.observerObjects.index(where: { $0.value == object } ) else {
            return
        }
        self.observerObjects.remove(at: index)
    }
    
    @objc func willShowKeyBoard(note: Notification) {
        self.observerObjects = self.observerObjects.filter { $0.value != nil }
        for each in self.observerObjects {
            each.perform(selector: #selector(willShowKeyBoard), object: note)
        }
    }
    
    @objc func didShowKeyBoard(note: Notification) {
        for each in self.observerObjects {
            each.perform(selector: #selector(didShowKeyBoard), object: note)
        }
    }
    @objc func willHideKeyBoard(note: Notification) {
        self.observerObjects = self.observerObjects.filter { $0.value != nil }
        for each in self.observerObjects {
            each.perform(selector: #selector(willHideKeyBoard), object: note)
        }
    }
    
    @objc func didHideKeyBoard(note: Notification) {
        for each in self.observerObjects {
            each.perform(selector: #selector(didHideKeyBoard), object: note)
        }
    }
    
    @objc func willChangeKeyBoardFrame(note: Notification) {
        for each in self.observerObjects {
            each.perform(selector: #selector(willChangeKeyBoardFrame), object: note)
        }
    }
    
    @objc func didChangeKeyBoardFrame(note: Notification) {
        for each in self.observerObjects {
            each.perform(selector: #selector(didChangeKeyBoardFrame), object: note)
        }
    }
    
}

@objc public protocol KeyBoardNotification {
    @objc optional func willShowKeyBoard(note: Notification)
    @objc optional func didShowKeyBoard(note: Notification)
    @objc optional func willHideKeyBoard(note: Notification)
    @objc optional func didHideKeyBoard(note: Notification)
    @objc optional func willChangeKeyBoardFrame(note: Notification)
    @objc optional func didChangeKeyBoardFrame(note: Notification)
    
}

extension Notification {
    var keyboardFrame: CGRect? { return self.userInfo?[UIKeyboardFrameEndUserInfoKey] as? CGRect }
    var keyboardSize: CGSize? { return self.keyboardFrame?.size }
    
}
