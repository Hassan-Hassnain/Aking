//
//  LoginVC.swift
//  Aking
//
//  Created by Usama Sadiq on 4/21/20.
//  Copyright © 2020 Usama Sadiq. All rights reserved.
//

import UIKit
import ProgressHUD

class LoginVC: UIViewController {
    
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateNavBarAppearance(color: .white, title: nil)
        navigationController?.hideHairline()
    }
    @IBAction func backButtonTapped(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    @IBAction func createAccountButtonTapped(_ sender: Any) {
        pushVC(viewController: SignUpVC.className, animated: true)
    }
    @IBAction func forgotPassordButtonTapped(_ sender: Any) {
        pushVC(viewController: ForgotPasswordVC.className, animated: true)
    }
    @IBAction func LoginButtonTapped(_ sender: Any) {
        emailTF.validateField(withMessage: KFieldValid.EMPTY_EMAIL)
        passwordTF.validateField(withMessage: KFieldValid.EMPTY_PASSWORD)
        ProgressHUD.show()
        AuthService.instance.loginUser(withEmail: emailTF.text!, andPassword: passwordTF.text!) { (success, error) in
            if !success {
                ProgressHUD.showError(error?.localizedDescription)
                print("Login Failed!")
            } else {
                ProgressHUD.dismiss()
                let vc = self.storyboard?.instantiateViewController(identifier: TabbarViewController.className)
                vc?.modalPresentationStyle = .fullScreen
                self.presentDetail(vc!)
                print("Login Success!")
            }
        }
    }
    
    
}
