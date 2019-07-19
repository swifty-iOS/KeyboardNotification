# KeyboardNotification

KeyboardNotification protocol helps to get all the Keyboard events like **Show / Hide / Frame Changes** along with keyboard ***frame*** and ***size***.


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


## How to Use

It is very simple and easy to use. Just adopt **KeyboardNotification** protocol to your Controller class or any class. Register your class for desire [Notification.Keyboard](/Source) type.

 
```swift
class ViewController: UIViewController, KeyboardNotification {
	...
    override func viewDidLoad(_ animated: Bool) {
        super.viewDidLoad(animated)
        // Register Keboard notification with inline closure
         registerKeyboardNotification(.willShow) { note _ in 
         // Get notifcation when Keyboard will appears

         }

         // register Keyboard notification with inline function
         registerKeyboardNotification(.willHide, handler: willHideKeyboard)
    }
	
    func willHideKeyboard(_ note: Notification) {
        // Write your code while hiding keyboard
        ....
        // Access keyboard frame
        let frame = note.keyboardFrame

    }
}
```

For more details check for sample project.

## Licence

**[MIT](LICENSE)**
