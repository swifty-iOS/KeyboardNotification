//
//  ViewController.swift
//  Sample
//
//  Created by Manish Bhande on 21/01/17.
//  Copyright © 2017 Manish Bhande. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
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
        self.registerKeyBoardNotification()
        let v = ViewController()
        v.registerKeyBoardNotification()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.deregisterKeyBoardNotification()
    }
    
}

extension ViewController: KeyBoardNotification {
    
    func willShowKeyBoard(note: Notification) {
        print(note.keyboardFrame ?? "No frame detected")
        print("Keybaord will show")
    }
    
    func didShowKeyBoard(note: Notification) {
        print(note.keyboardFrame ?? "No frame detected")
        print("Keyboard did show")
    }
    
    func willHideKeyBoard(note: Notification) {
        print(note.keyboardSize ?? "No size detected")
        print("Keyboard will hide")
    }
    
    func didHideKeyBoard(note: Notification) {
        print(note.keyboardFrame ?? "No frame detected")
        print("Keybaord did hide")
    }
}

extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
