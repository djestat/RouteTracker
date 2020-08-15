//
//  LoginViewController.swift
//  RouteTracker
//
//  Created by Igor on 13.04.2020.
//  Copyright © 2020 Igor Gapanovich. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

final class LoginViewController: UIViewController {

    @IBOutlet weak var logoImageView: UIImageView! 
    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButtonOutlet: UIButton!
    
    var onMap: (() -> Void)?
    var onRegistration: (() -> Void)?
    let bag = DisposeBag()
    let realmAdapter: RealmAdapter = RealmAdapter()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        configureLoginButton()
    }
    
    @IBAction func loginButton() {
        if let login = loginTextField.text, let password = passwordTextField.text {
            let user = realmAdapter.searchUserLogin(login)
            print("login: \(user.login) ! pass: \(user.password)")
            if user.login != "nouser" && user.password != "no password" {
                if login == user.login && password == user.password {
                    UserDefaults.standard.set(true, forKey: "isLogin")
                    onMap?()
                } else {
                    wrongLogin()
                }
            } else {
                wrongLogin()
            }
        }
    }
    
    @IBAction func registrationButton() {
        onRegistration?()
    }
    
    //MARK: - Configure Login Button activity

    func configureLoginButton() {
        Observable.combineLatest(
            loginTextField.rx.text,
            passwordTextField.rx.text
        ).map { login, password in
            var result: Bool = false
            let count: Int = 4
            if let login = login, let password = password {
                if login.count >= count && password.count >= count {
                    result = true
                }
            }
            return result
        }.bind { [weak loginButtonOutlet] inputFilled in
            loginButtonOutlet?.isEnabled = inputFilled
        }.disposed(by: bag)
    }
    
    //MARK: - Alert error Login
    
    func wrongLogin() {
        let alert = UIAlertController(title: "Error authorization!", message: "Check login or password and try again!", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
}
