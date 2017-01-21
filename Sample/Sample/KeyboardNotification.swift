//
//  KeyBoardNotification.swift
//  DigitalCompanion
//
//  Created by Manish on 1/18/17.
//  Copyright © 2017 Manish. All rights reserved.
//

import Foundation

extension NSObject {
    func registerKeyBoardNotification() {
        KeyBoardNotificationRegister.register(object: self)
    }
    func deregisterKeyBoardNotification() {
        KeyBoardNotificationRegister.deregister(object: self)
    }
}

fileprivate class KeyBoardNotificationRegister {
    class func register(object: NSObject) {
        NotificationCenter.default.addObserver(object, selector:  #selector(willShowKeyBoard), name:NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(object, selector:  #selector(didShowKeyBoard), name:NSNotification.Name.UIKeyboardDidShow, object: nil)

        NotificationCenter.default.addObserver(object, selector:  #selector(willHideKeyBoard), name:NSNotification.Name.UIKeyboardWillHide, object: nil)
        NotificationCenter.default.addObserver(object, selector:  #selector(didHideKeyBoard), name:NSNotification.Name.UIKeyboardDidHide, object: nil)
    }
    class func deregister(object: NSObject) {
        NotificationCenter.default.removeObserver(object, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(object, name: NSNotification.Name.UIKeyboardDidShow, object: nil)
        NotificationCenter.default.removeObserver(object, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        NotificationCenter.default.removeObserver(object, name: NSNotification.Name.UIKeyboardDidShow, object: nil)
    }
    @objc func willShowKeyBoard(note: Notification) { }
    @objc func didShowKeyBoard(note: Notification) { }
    @objc func willHideKeyBoard(note: Notification) { }
    @objc func didHideKeyBoard(note: Notification) { }
}

@objc protocol KeyBoardNotification {
    @objc func willShowKeyBoard(note: Notification)
    @objc func didShowKeyBoard(note: Notification)
    @objc func willHideKeyBoard(note: Notification)
    @objc func didHideKeyBoard(note: Notification)
}
