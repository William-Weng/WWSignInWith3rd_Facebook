//
//  WWSignInWith3rd+Facebook.swift
//  WWSignInWith3rd+Facebook
//
//  Created by William.Weng on 2023/9/13.
//

import UIKit
import FacebookLogin
import WWSignInWith3rd_Apple

// MARK: - 第三方登入
extension WWSignInWith3rd {
    
    /// [Facebook SDK - 16.0.0](https://github.com/facebook/facebook-ios-sdk)
    open class Facebook: NSObject {
        
        public static let shared = Facebook()
        
        private override init() {}
    }
}

// MARK: - 公開函式
public extension WWSignInWith3rd.Facebook {
    
    /// [起動設定 - application(_:didFinishLaunchingWithOptions:)](https://developer.apple.com/documentation/uikit/uiapplicationdelegate/1622921-application)
    /// - Parameters:
    ///   - application: UIApplication
    ///   - launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    func canLaunching(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        return ApplicationDelegate.shared.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
    
    /// [OpenURL設定 - application(_:open:options:)](https://developer.apple.com/documentation/uikit/uiapplicationdelegate/1623112-application)
    /// - Parameters:
    ///   - application: UIApplication
    ///   - url: URL
    ///   - sourceApplication: String?
    ///   - annotation: Any?
    /// - Returns: Bool
    func canOpenURL(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any?) -> Bool {
        return ApplicationDelegate.shared.application(application, open: url, sourceApplication: sourceApplication, annotation: annotation)
    }
    
    /// 加入Facebook SignIn的原生按鈕
    /// - Parameters:
    ///   - frame: CGRect?
    ///   - delegate: LoginButtonDelegate
    ///   - permissions: [String]
    /// - Returns: FBLoginButton
    func loginButton(with frame: CGRect?, delegate: LoginButtonDelegate, permissions: [String] = ["public_profile", "email"]) -> FBLoginButton {

        let loginButton = FBLoginButton()
        
        loginButton.delegate = delegate
        loginButton.permissions = permissions
        
        if let frame = frame { loginButton.frame = frame }

        return loginButton
    }
    
    /// [使用facebook登入 + 取得使用者資訊](https://developers.facebook.com/docs/facebook-login/ios)
    /// - Parameters:
    ///   - viewController: [UIViewController](https://github.com/facebook/facebook-ios-sdk)
    ///   - permissions: [String](https://developers.facebook.com)
    ///   - result: Result<LoginManagerLoginResult?, Error>
    func login(withPresenting viewController: UIViewController, permissions: [String] = ["public_profile", "email"], result: @escaping (Result<[String: Any]?, Error>) -> Void) {
        
        login(from: viewController, permissions: permissions) { [weak self] loginResult in
            
            guard let this = self else { result(.success(nil)); return }
            
            switch loginResult {
            case .failure(let error): result(.failure(error))
            case .success(let loginResult):
                
                guard let loginResult = loginResult,
                      !loginResult.isCancelled
                else {
                    result(.success(nil)); return
                }
                
                this.userInfomation { userInfoResult in
                    
                    switch userInfoResult {
                    case .failure(let error): result(.failure(error))
                    case .success(let info):
                        guard let dictionary = info as? [String: Any] else { result(.success(nil)); return }
                        result(.success(dictionary))
                    }
                }
            }
        }
    }
    
    /// 使用facebook登入
    /// - Parameters:
    ///   - viewController: UIViewController
    ///   - permissions: [String]
    ///   - result: Result<LoginManagerLoginResult?, Error>
    func login(from viewController: UIViewController, permissions: [String] = ["public_profile", "email"], result: @escaping (Result<LoginManagerLoginResult?, Error>) -> Void) {
                
        LoginManager().logIn(permissions: permissions, from: viewController) { (_result, _error) in
            if let error = _error { result(.failure(error)); return }
            result(.success(_result))
        }
    }

    /// 使用facebook登出
    func logout() { LoginManager().logOut() }
        
    /// 使用者資訊
    /// - Parameters:
    ///   - graphPath: String
    ///   - parameters: [String: String]
    ///   - reault: Result<Any?, Error>
    func userInfomation(graphPath: String = "me", parameters: [String: String] = ["fields": "id, email, name"], reault: @escaping ((Result<Any?, Error>) -> Void)) {
        
        let request = GraphRequest(graphPath: graphPath, parameters: parameters)
        
        request.start { (_response, _result, _error) in
            if let error = _error { reault(.failure(error)) }
            reault(.success(_result))
        }
    }
    
    /// 登入狀態 (沒Token / Token過期)
    /// - Returns: Bool
    func isLogin() -> Bool {
        guard let isExpired = isExpired() else { return false }
        return !isExpired
    }
    
    /// 登入的狀態 (有沒有記錄Token)
    func accessToken() -> AccessToken? { return AccessToken.current }
    
    /// Token有沒有到期
    /// - Returns: Bool?
    func isExpired() -> Bool? {
        guard let token = accessToken() else { return nil }
        return token.isExpired
    }
}
