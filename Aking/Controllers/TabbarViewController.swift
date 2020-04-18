//
//  TabbarViewController.swift
//  Aking
//
//  Created by Usama Sadiq on 4/7/20.
//  Copyright © 2020 Usama Sadiq. All rights reserved.
//

import UIKit


class TabbarViewController: UITabBarController {
    
    var addTaskView: AddView?
    var isAddViewPresented: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        delegate = self
        
    }
    
    fileprivate func showAddView() {
        let presenter = selectedViewController
        let addView = AddView()
        addView.tag = 100
        addView.fixInView(presenter?.view)
        presenter?.view.addSubview(addView)
        
    }
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        print(tabBarController)
    }
    
    
}


extension TabbarViewController: UITabBarControllerDelegate{
    @objc func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        if viewController is AddVC {
            if !isAddViewPresented {
                showAddView()
                isAddViewPresented = true
            }
//            guard let vc = storyboard?.instantiateViewController(identifier: MyTaskVC.className) else {return false}
//            vc.modalPresentationStyle = .fullScreen
//            self.present(vc, animated: true, completion: nil)
//            show(vc, sender: self)
            return false
        } else {
            for subview in viewController.view.subviews {
                if (subview.tag == 100) {
                    subview.removeFromSuperview()
                }
            }
            isAddViewPresented = false
            return true
        }
        print(selectedIndex)
        print(selectedViewController)
    }
    
    
}


