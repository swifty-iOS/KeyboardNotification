//
//  ViewController.swift
//  Sample
//
//  Created by Manish Bhande on 21/01/17.
//  Copyright © 2017 Manish Bhande. All rights reserved.
//

import UIKit

class ViewController: UIViewController, KeyboardNotification {
    
    var keyboardTokens: [NSObjectProtocol]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        registerKeyboardNotification()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        deregisterKeyboardNotification()
    }
    
}

extension ViewController {
    
    func willChangeKeyboardFrame(_ note: Notification) {
        print("Keyboard will change frame", "\nFrame:", note.keyboardFrame!, "Size:", note.keyboardSize!)
    }
    
    func didChangeKeyboardFrame(_ note: Notification) {
        print("Keyboard did change frame", "\nFrame:", note.keyboardFrame!, "Size:", note.keyboardSize!)
    }
    
    func willShowKeyboard(_ note: Notification) {
        print("Keybaord will show")
    }
    
    func didShowKeyboard(_ note: Notification) {
        print("Keyboard did show")
    }
    
    func willHideKeyboard(_ note: Notification) {
        print("Keyboard will hide")
    }
    
    func didHideKeyboard(_ note: Notification) {
        print("Keybaord did hide")
    }
    
}

extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
