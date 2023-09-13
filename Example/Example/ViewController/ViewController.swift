//
//  ViewController.swift
//  Example
//
//  Created by William.Weng on 2023/9/11.
//  ~/Library/Caches/org.swift.swiftpm/

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
