//
//  RegistrationViewController.swift
//  RouteTracker
//
//  Created by Igor on 13.04.2020.
//  Copyright © 2020 Igor Gapanovich. All rights reserved.
//

import UIKit

class RegistrationViewController: UIViewController {

    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    let realmAdapter: RealmAdapter = RealmAdapter()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func backButton() {
    }
    
    @IBAction func registrateButton() {
        if !loginTextField.text!.isEmpty || !passwordTextField.text!.isEmpty {
            let coutSymbols: Int = 4
            if loginTextField.text!.count >= coutSymbols && passwordTextField.text!.count >= coutSymbols {
                let login = loginTextField.text!
                let password = passwordTextField.text!
                realmAdapter.saveUserLogin(login, password)
                print("l: \(login) ! p: \(password)")
            }
        }
    }
}
