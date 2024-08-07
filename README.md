# WWSignInWith3rd+Facebook

[![Swift-5.6](https://img.shields.io/badge/Swift-5.6-orange.svg?style=flat)](https://developer.apple.com/swift/) [![iOS-14.0](https://img.shields.io/badge/iOS-14.0-pink.svg?style=flat)](https://developer.apple.com/swift/) ![](https://img.shields.io/github/v/tag/William-Weng/WWSignInWith3rd_Facebook) [![Swift Package Manager-SUCCESS](https://img.shields.io/badge/Swift_Package_Manager-SUCCESS-blue.svg?style=flat)](https://developer.apple.com/swift/) [![LICENSE](https://img.shields.io/badge/LICENSE-MIT-yellow.svg?style=flat)](https://developer.apple.com/swift/)

### [Introduction - 簡介](https://swiftpackageindex.com/William-Weng)
- [Use Facebook third-party login.](https://medium.com/彼得潘的-swift-ios-app-開發教室/19-實作ios-app登入facebook第三方登入平台-b4968f3fbd9a)
- [使用Facebook的第三方登入。](https://medium.com/彼得潘的-swift-ios-app-開發問題解答集/實作-ios-app-的-facebook-登入功能-96c981d482cc)

![](./Example.gif)

### [Installation with Swift Package Manager](https://medium.com/彼得潘的-swift-ios-app-開發問題解答集/使用-spm-安裝第三方套件-xcode-11-新功能-2c4ffcf85b4b)
```js
dependencies: [
    .package(url: "https://github.com/William-Weng/WWSignInWith3rd_Facebook.git", .upToNextMajor(from: "1.0.0"))
]
```

### Function - 可用函式
|函式|功能|
|-|-|
|canLaunching(_:didFinishLaunchingWithOptions:)|起動設定 - application(_:didFinishLaunchingWithOptions:)|
|canOpenURL(_:sourceApplication:annotation:)|OpenURL設定 - application(_:open:options:)|
|loginButton(with:delegate:permissions:)|加入Facebook SignIn的原生按鈕|
|login(withPresenting:permissions:result:)|使用facebook登入 + 取得使用者資訊|
|login(from:permissions:result:)|使用facebook登入|
|logout()|使用facebook登出|
|userInfomation(graphPath:parameters:reault:)|使用者資訊|
|isLogin()|登入狀態 (沒Token / Token過期)|
|accessToken()|登入的狀態 (有沒有記錄Token)|
|isExpired()|Token有沒有到期|

### Example
```swift
import UIKit
import WWSignInWith3rd_Apple
import WWSignInWith3rd_Facebook

@main
final class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        return WWSignInWith3rd.Facebook.shared.canLaunching(application, didFinishLaunchingWithOptions: launchOptions)
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {

        let sourceApplication = options[UIApplication.OpenURLOptionsKey.sourceApplication] as? String
        let annotation = options[UIApplication.OpenURLOptionsKey.annotation]
        
        return WWSignInWith3rd.Facebook.shared.canOpenURL(app, open: url, sourceApplication: sourceApplication, annotation: annotation)
    }
}

```
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
    /// [開啟Keychain sharing功能](https://8085studio.wordpress.com/2015/08/29/ios筆記-使用keychain在app間共享資料/)
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
