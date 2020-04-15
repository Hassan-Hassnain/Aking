//
//  TabbarViewController.swift
//  Aking
//
//  Created by Usama Sadiq on 4/7/20.
//  Copyright © 2020 Usama Sadiq. All rights reserved.
//

import UIKit

@available(iOS 13.0, *)
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
        view.addSubview(addView)
        addView.fixInView(presenter?.view)
        presenter?.view.addSubview(addView)
        
    }
    
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {

    }
    
    
}

@available(iOS 13.0, *)
extension TabbarViewController: UITabBarControllerDelegate{
    @objc func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        if viewController is AddVC {
            if !isAddViewPresented {
                showAddView()
                isAddViewPresented = true
            }
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
    }


}


