//
//  LoginVC.swift
//  Aking
//
//  Created by Usama Sadiq on 4/21/20.
//  Copyright © 2020 Usama Sadiq. All rights reserved.
//

import UIKit
import ProgressHUD
import Firebase

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
                self.downloadDataFromFirebase()
            }
        }
    }
    
    func downloadDataFromFirebase(){
//        for i in DataService.instance.checkListItems {
//            GDataService.instance.uploadCheckList(withCheckList: i) { (success) in
//                if success {
//                    print("Item Uploaded")
//                }
//            }
//        }
//        GDataService.instance.getAllCheckList { (checkLists) in
//            print(checkLists as Any)
//        }
        
//        GDataService.instance.uploadProject(withProject: Project(id: "", color: #colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1), projectName: "Home", numberOfTasks: "10")) { (success) in
//            print("Done")
//        }
//        GDataService.instance.getAllProject { (s) in
//            
//        }
    }
    
    
    
}


