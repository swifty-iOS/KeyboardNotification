# KeyboardNotification

KeyboardNotification protocol helps to manage Keyboard event like **Show / Hide** along with keyboard ***frame*** and ***size***.


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

It is very simple and easy to use. Register object for keybaord Notification:

```swift
object.registerKeyBoardNotification()
```
> Note: ***object*** must a subclass of **NSObject**

It will register object to handle keyboard Notification until **object is alive**.

If you want to handle notifications event if object is **released from memory**, then register your object like:

```swift
 self.registerKeyBoardNotification(keepAlive: true)
```
>**Note**: Using ***keepAlive*** holds object in memory and will not be released until **deregisterKeyBoardNotification()** method called explicity.

If your no more interested to handle notification you should **deregister** your object like:

```swift
self.deregisterKeyBoardNotification()
``` 

##Impleting Protocol

To handle notification of Keyboard, just implement **KeyboardNotification** protocol on registered object. Aslo you can access **keyboardFrame** and  **keyboardSize** directly from notification object.

```swift
@objc protocol KeyBoardNotification {
    @objc optional func willShowKeyBoard(note: Notification)
    @objc optional func didShowKeyBoard(note: Notification)
    @objc optional func willHideKeyBoard(note: Notification)
    @objc optional func didHideKeyBoard(note: Notification)
}
```

###Example

```swift
extension ViewController: KeyBoardNotification {
    internal func willShowKeyBoard(note: Notification) {
        print(note.keyboardFrame ?? "No frame detected")
        print("Keybaord will show")
    }
    func willHideKeyBoard(note: Notification) {
        print(note.keyboardSize ?? "No size detected")
        print("Keyboard will hide")
    }
}

```

##Licence

**[MIT](LICENSE)**
