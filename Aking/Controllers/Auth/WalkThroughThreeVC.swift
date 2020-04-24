//
//  WalkThroughThreeVC.swift
//  Aking
//
//  Created by Usama Sadiq on 4/25/20.
//  Copyright © 2020 Usama Sadiq. All rights reserved.
//

import UIKit

class WalkThroughThreeVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    @IBAction func getStartedButtonTapped(_ sender: UIButton) {
        guard let vc = storyboard?.instantiateViewController(withIdentifier: LoginVC.className) else { return }
        vc.modalPresentationStyle = .fullScreen
        pushVC(viewController: LoginVC.className, animated: true)
    }
    
    @IBAction func loginButtonTapped(_ sender: UIButton) {
        guard let vc = storyboard?.instantiateViewController(withIdentifier: LoginVC.className) else { return }
        vc.modalPresentationStyle = .fullScreen
        presentDetail(vc)
    }
    
    
}
