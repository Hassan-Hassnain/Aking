//
//  ResetPasswordVC.swift
//  Aking
//
//  Created by Usama Sadiq on 4/21/20.
//  Copyright © 2020 Usama Sadiq. All rights reserved.
//

import UIKit

class ResetPasswordVC: UIViewController {
    
    @IBOutlet weak var resetCodeTF: UITextField!
    @IBOutlet weak var newPasswordTF: UITextField!
    @IBOutlet weak var confirmPassword: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func backButtonTapped(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func sendRequestButtonTapped(_ sender: Any) {
        
        //will enclosed in password reset AuthService func closure

        let vc = self.storyboard?.instantiateViewController(withIdentifier: SuccessfulVC.className)
        vc?.modalPresentationStyle = .fullScreen
        self.presentDetail(vc!)
    }
    
    
    
}
