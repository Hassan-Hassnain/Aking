//
//  WalkThroughOneVC.swift
//  Aking
//
//  Created by Usama Sadiq on 4/25/20.
//  Copyright © 2020 Usama Sadiq. All rights reserved.
//

import UIKit

class WalkThroughOneVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func getStartedButtonTapped(_ sender: UIButton) {
        guard let vc = storyboard?.instantiateViewController(withIdentifier: WalkThroughTwoVC.className) else { return }
        vc.modalPresentationStyle = .fullScreen
        pushVC(viewController: WalkThroughTwoVC.className, animated: true)
    }
    
    @IBAction func loginButtonTapped(_ sender: UIButton) {
        guard let vc = storyboard?.instantiateViewController(withIdentifier: LoginVC.className) else { return }
        vc.modalPresentationStyle = .fullScreen
        presentDetail(vc)
    }
    
}

