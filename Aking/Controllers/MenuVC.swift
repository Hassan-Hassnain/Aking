//
//  SecondViewController.swift
//  Aking
//
//  Created by Usama Sadiq on 4/5/20.
//  Copyright © 2020 Usama Sadiq. All rights reserved.
//

import UIKit

class MenuVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let vu = TaskFilterView(frame: CGRect(x: 50, y: 50, width: 228, height: 130))
        view.addSubview(vu)
    }

    
    fileprivate func showAddView() {
           let filter = TaskFilterView(frame: CGRect(x: 50, y: 50, width: 100, height: 100))
           filter.tag = 100
        filter.backgroundColor = .magenta
           view.addSubview(filter)
           filter.fixInView(view)
       }

}

