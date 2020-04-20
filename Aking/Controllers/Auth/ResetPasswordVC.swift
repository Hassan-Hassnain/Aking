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
        
        updateNavBarAppearance(color: .white, title: nil)
        navigationController?.hideHairline()
    }
    
    @IBAction func backButtonTapped(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func sendRequestButtonTapped(_ sender: Any) {
    }
    
    
    
}
