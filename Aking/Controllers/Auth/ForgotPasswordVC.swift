//
//  ForgotPasswordVC.swift
//  Aking
//
//  Created by Usama Sadiq on 4/21/20.
//  Copyright © 2020 Usama Sadiq. All rights reserved.
//

import UIKit
import ProgressHUD

class ForgotPasswordVC: UIViewController {

    @IBOutlet weak var emailTF: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        updateNavBarAppearance(color: .white, title: nil)
        navigationController?.hideHairline()
    }
    
    @IBAction func backButtonTapped(_ sender: Any) {
           navigationController?.popViewController(animated: true)
       }
    
    @IBAction func sendRequestButtonTapped(_ sender: Any) {
        ProgressHUD.show()
        emailTF.validateField(withMessage: KFieldValid.EMPTY_EMAIL)
        AuthService.instance.resetPassword(withEmail: emailTF.text!) { (success, message) in
            if success {
                ProgressHUD.showSuccess(message)
                DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(4), execute: {
                    self.pushVC(viewController: LoginVC.className, animated: true)
                })
                
            } else {
                ProgressHUD.showError(message)
            }
        }
    }
    


}
