//
//  WalkThroughTwoVC.swift
//  Aking
//
//  Created by Usama Sadiq on 4/25/20.
//  Copyright © 2020 Usama Sadiq. All rights reserved.
//

import UIKit

class WalkThroughTwoVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }

    @IBAction func getStartedButtonTapped(_ sender: UIButton) {
           guard let vc = storyboard?.instantiateViewController(withIdentifier: WalkThroughThreeVC.className) else { return }
           vc.modalPresentationStyle = .fullScreen
           presentDetail(vc)
       }
       
       @IBAction func loginButtonTapped(_ sender: UIButton) {
           guard let vc = storyboard?.instantiateViewController(withIdentifier: AuthNavVC.className) else { return }
           vc.modalPresentationStyle = .fullScreen
           presentDetail(vc)
       }
    
}
