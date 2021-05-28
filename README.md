<p align="center">
  <img src="https://github.com/IlyasNN/PreventLookingManager/blob/master/Media/Icon.png" alt="Icon"/>
</p>
<H1 align="center">PreventLookingManager</H1>

[![Version](https://img.shields.io/cocoapods/v/PreventLookingManager.svg?style=flat)](https://cocoapods.org/pods/PreventLookingManager)
[![License](https://img.shields.io/cocoapods/l/PreventLookingManager.svg?style=flat)](https://cocoapods.org/pods/PreventLookingManager)
[![platform iOS](https://img.shields.io/badge/Platform-iOS-blue.svg?style=fla)]()

![Image alt](https://github.com/IlyasNN/PreventLookingManager/blob/readme/Media/Poster.png)

## Desription

Prevent looking manager is designed to prevent driver distraction while driving. Machine learning was used to achieve this goal. The camera tracks the driver's eyes and if he looks at the screen for a long time, a warning is triggered. Moreover, you can set the timeout and minimum speed, upon reaching which warnings will be triggered so as not to bother the user. Camera position also can be configured.

## Requirements

1) `IOS device - iPhone or iPad`
2) `Version of IOS >= 12.`
3) `User access to camera`
4) `User access to location (if you use speed)`

## Usage scenarios

First of all
```swift
    import PreventLookingManager
```
- #### PreventLookingAppManager - Singletone
You can use only one manager for all the app. Just subscribe objects for notifications. Manager can be reconfigured at any time.
1) Configure manager in `AppDelegate`
```swift
    let plmConfig = PreventLookingManagerConfig(timeout: 10,
                                                camera: .front)
    PreventLookingAppManager.configure(with: plmConfig)
```
2) Subscribe object for notifications
```swift
        PreventLookingAppManager.shared.didGetWarning.
                                    addListener(skipCurrent: true) { [weak self] _ in
            self?.showAlert(title: "App manager notification",
                            message: "This notification is recieved from 
                            the main PreventLookingAppManager (sigleton) 
                            to which this controller is subscribed")
        }
```
- #### PreventLookingManager - Local
User PreventLookingManager class to create local manager. Use delegate to interract with it
1. Create and configure manager in `Object`
```swift
    let preventLookingManager = PreventLookingManager()
    let plmConfig = PreventLookingManagerConfig(timeout: 10,
                                                camera: .front)
    preventLookingManager.configure(with: plmConfig)
```
2. Set delegate for `PreventLookingManager`
```swift
    preventLookingManager.delegate = <some Object>
```
3. Delegate should implement `PreventLookingManagerDelegate` protocol
```swift
    extension <Object>: PreventLookingManagerDelegate {
    
    func gotWarning() {
        // example
        self.showAlert(title: "Local manager notification",
                       message: "This notification is recieved from local PreventLookingManager via delegate methods")
    }
    
    func gotError(_ error: Error) {
        // example
        self.showAlert(title: "Error", message: error.localizedDescription)
    }
    
}
```

## Installation

PreventLookingManager is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'PreventLookingManager'
```

## Author

IlyasNN, ilyasolovyovr52@yandex.ru

## License

PreventLookingManager is available under the MIT license. See the LICENSE file for more info.
