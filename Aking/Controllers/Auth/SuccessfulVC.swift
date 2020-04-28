//
//  SuccessfulVC.swift
//  Aking
//
//  Created by Usama Sadiq on 4/25/20.
//  Copyright © 2020 Usama Sadiq. All rights reserved.
//

import UIKit

class SuccessfulVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2), execute: {
            let vc = self.storyboard?.instantiateViewController(identifier: LoginVC.className)
            vc?.modalPresentationStyle = .fullScreen
            self.presentDetail(vc!)
        })
    }


}
