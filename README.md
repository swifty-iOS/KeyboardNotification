# KeyboardNotification

KeyboardNotification protocol helps to get Keyboard event like **Show / Hide / Frame Changes** along with keyboard ***frame*** and ***size***.


## Installation

### CocoaPods

[CocoaPods](http://cocoapods.org) is a dependency manager for Cocoa projects. You can install it with the following command:

```bash
$ gem install cocoapods
```

To integrate ***KeyboardNotification*** into your Xcode project using CocoaPods, specify it in your `Podfile`:

```ruby
target '<Your Target Name>' do
    pod 'KeyboardNotification'
end
```

Then, run the following command:

```bash
$ pod install
```


##How to Use

It is very simple and easy to use. Just adopt **KeyboardNotification** protocol to your Controller class or any class. It will ask yoou declar a varibale ***keyboardTokens***.

 
```swift
class ViewController: UIViewController, KeyboardNotification {
	....
	var keyboardTokens: [NSObjectProtocol]?
	...
}
```

### Register Object
You need to **register** your class for keyboard notification just by calling.

```swift 
 	registerKeyboardNotification()
```

>**Note**: Once you register the object, then you must need to deregister you object.


### Deregister Object
If your no more interested to handle notification you should **deregister** your object like

```swift
	deregisterKeyboardNotification()
```

##Impleting Protocol

Once you register the object, you can automatically get all notification mentioned below. Aslo you can access **keyboardFrame** and  **keyboardSize** directly from notification object.

```swift
    
    func willShowKeyboard(_ note: Notification)
    func didShowKeyboard(_ note: Notification)
    func willHideKeyboard(_ note: Notification)
    func didHideKeyboard(_ note: Notification)
    func willChangeKeyboardFrame(_ note: Notification)
    func didChangeKeyboardFrame(_ note: Notification)
    

```

###Example

```swift
extension ViewController {

	func willShowKeyboard(_ note: Notification) {
	
		let frame = note.keyboardFrame
    }
    
    
    func didHideKeyboard(_ note: Notification) {
    	
    	let size = note.keyboardSize   
   	}    

}

```

For more details check for sample project.

##Licence

**[MIT](LICENSE)**
