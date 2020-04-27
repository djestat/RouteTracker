//
//  RegistrationViewController.swift
//  RouteTracker
//
//  Created by Igor on 13.04.2020.
//  Copyright © 2020 Igor Gapanovich. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

final class RegistrationViewController: UIViewController {

    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var registrateButtonOutlet: UIButton!
    
    let realmAdapter: RealmAdapter = RealmAdapter()
    let bag = DisposeBag()
    var onLogin: (() -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        configureRegistrationButton()
    }
    
    @IBAction func backButton() {
        onLogin?()
    }
    
    @IBAction func registrateButton() {
        if let login = loginTextField.text, let password = passwordTextField.text {
            realmAdapter.saveUserLogin(login, password)
            registrationAlert()
            print("l: \(login) ! p: \(password)")
        }
    }
    
    //MARK: - Configure Login Button activity

    func configureRegistrationButton() {
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
        }.bind { [weak registrateButtonOutlet] inputFilled in
            registrateButtonOutlet?.isEnabled = inputFilled
        }.disposed(by: bag)
    }
    
    //MARK: - Alert registration
    
    func registrationAlert() {
        let alert = UIAlertController(title: "Successful registration!", message: "Your login and password was added in data base.", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
