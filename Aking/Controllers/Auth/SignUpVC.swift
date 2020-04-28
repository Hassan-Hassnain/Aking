//
//  SignUpVC.swift
//  Aking
//
//  Created by Usama Sadiq on 4/21/20.
//  Copyright © 2020 Usama Sadiq. All rights reserved.
//

import UIKit
import ProgressHUD

class SignUpVC: UIViewController {
    
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var confirmPasswordTF: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func backButtonTapped(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func sendRequestButtonTapped(_ sender: Any) {
        validateTextFields()
        signUp()
    }
    private func validateTextFields() {
        confirmPasswordTF.validateField(withMessage: KFieldValid.EMPTY_CONFIRM_PASSWORD)
        passwordTF.validateField(withMessage: KFieldValid.EMPTY_PASSWORD)
        emailTF.validateField(withMessage: KFieldValid.EMPTY_EMAIL)
        nameTF.validateField(withMessage: KFieldValid.EMPTY_USERNAME)
        
        if passwordTF.text != confirmPasswordTF.text! {
            ProgressHUD.showError(KFieldValid.PASSWORD_NOT_MATCH)
        }
        
    }
    func signUp() {
        ProgressHUD.show()
        self.validateTextFields()
        AuthService.instance.createUser(withEmail:emailTF.text!, andPassword: passwordTF.text!) { (user) in
            guard let user = user else {return}
            let dict = [KUserData.USER_NAME: self.nameTF.text!, KUserData.UESR_EMAIL:self.emailTF.text!]
            DataService.instance.updateDBUser(uid: user.uid, userData: dict) {(success) in
                if success {
                    ProgressHUD.showSuccess(KFireMessages.USER_DATA_SAVED)
                    DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(4), execute: {
                        self.navigationController?.popViewController(animated: true)
                    })
                } else {
                    ProgressHUD.showError(KFireMessages.REGISTRATION_FAILED)
                    ProgressHUD.dismiss()
                }
                
            }
        }
    }
}
