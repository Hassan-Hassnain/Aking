//
//  WalkThroughOneVC.swift
//  Aking
//
//  Created by Usama Sadiq on 4/25/20.
//  Copyright © 2020 Usama Sadiq. All rights reserved.
//

import UIKit
import Firebase

class WalkThroughOneVC: UIViewController {
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
          super.viewDidAppear(animated)
          if Auth.auth().currentUser != nil {
              let vc = self.storyboard?.instantiateViewController(withIdentifier: TabbarViewController.className)
              vc?.modalPresentationStyle = .fullScreen
              self.presentDetail(vc!)
              print("Already logged in with \(String(describing: Auth.auth().currentUser?.email))!")
          } else {
              print("No user logged in")
          }
      }
    
    @IBAction func getStartedButtonTapped(_ sender: UIButton) {
        guard let vc = storyboard?.instantiateViewController(withIdentifier: WalkThroughTwoVC.className) else { return }
        vc.modalPresentationStyle = .fullScreen
        presentDetail(vc)
    }
    
    @IBAction func loginButtonTapped(_ sender: UIButton) {
        guard let vc = storyboard?.instantiateViewController(withIdentifier: AuthNavVC.className) else { return }
        vc.modalPresentationStyle = .fullScreen
        presentDetail(vc)
    }
    
}

