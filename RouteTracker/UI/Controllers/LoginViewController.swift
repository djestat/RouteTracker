//
//  LoginViewController.swift
//  RouteTracker
//
//  Created by Igor on 13.04.2020.
//  Copyright © 2020 Igor Gapanovich. All rights reserved.
//

import UIKit

final class LoginViewController: UIViewController {

    @IBOutlet weak var logoImageView: UIImageView! {
        didSet {
            logoImageView.layer.cornerRadius = 10
        }
    }
    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    var onMap: (() -> Void)?
    var onRegistration: (() -> Void)?
    
    let realmAdapter: RealmAdapter = RealmAdapter()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
    }
    
    @IBAction func loginButton() {
        if !loginTextField.text!.isEmpty || !passwordTextField.text!.isEmpty {
            let user = realmAdapter.searchUserLogin(loginTextField.text!)
            print("login: \(user.login) ! pass: \(user.password)")
            if user.login != "nouser" && user.password != "no password" {
                if loginTextField.text! == user.login && passwordTextField.text! == user.password {
                    print("OLA!!!!")
                    UserDefaults.standard.set(true, forKey: "isLogin")
                    onMap?()
                } else {
                    print("NO")
                }
            }
        }
    }
    
    @IBAction func registrationButton() {
        onRegistration?()
    }
    
}
