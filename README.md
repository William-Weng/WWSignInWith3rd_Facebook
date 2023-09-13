# WWSignInWith3rd+Facebook

[![Swift-5.7](https://img.shields.io/badge/Swift-5.7-orange.svg?style=flat)](https://developer.apple.com/swift/) [![iOS-14.0](https://img.shields.io/badge/iOS-14.0-pink.svg?style=flat)](https://developer.apple.com/swift/) ![](https://img.shields.io/github/v/tag/William-Weng/WWSignInWith3rd_Facebook) [![Swift Package Manager-SUCCESS](https://img.shields.io/badge/Swift_Package_Manager-SUCCESS-blue.svg?style=flat)](https://developer.apple.com/swift/) [![LICENSE](https://img.shields.io/badge/LICENSE-MIT-yellow.svg?style=flat)](https://developer.apple.com/swift/)

[Use Facebook third-party login.](https://medium.com/彼得潘的-swift-ios-app-開發教室/19-實作ios-app登入facebook第三方登入平台-b4968f3fbd9a)

[使用Facebook的第三方登入。](https://medium.com/彼得潘的-swift-ios-app-開發問題解答集/實作-ios-app-的-facebook-登入功能-96c981d482cc)

![](./Example.gif)

### [Installation with Swift Package Manager](https://medium.com/彼得潘的-swift-ios-app-開發問題解答集/使用-spm-安裝第三方套件-xcode-11-新功能-2c4ffcf85b4b)
```js
dependencies: [
    .package(url: "https://github.com/William-Weng/WWSignInWith3rd_Facebook.git", .upToNextMajor(from: "1.0.0"))
]
```

### Example
```swift
import UIKit
import WWPrint
import WWSignInWith3rd_Apple
import WWSignInWith3rd_Facebook

final class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    /// 設定 <FacebookAppID> + <FacebookClientToken> + <FacebookDisplayName> + <FacebookScheme>
    /// - Parameter sender: UIButton
    @IBAction func signInWithFacebook(_ sender: UIButton) {
        
        WWSignInWith3rd.Facebook.shared.login(withPresenting: self) { result in
            switch result {
            case .failure(let error): wwPrint(error)
            case .success(let info): wwPrint(info)
            }
        }
    }
}
```
