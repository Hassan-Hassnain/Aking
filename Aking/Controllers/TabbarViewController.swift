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
    var presenter: UIViewController?
    
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
    
    func initAddView(){
        addTaskView = AddView()
        addTaskView?.fixInView(selectedViewController?.view)
        addTaskView?.tag = 100
    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
//        if presenter != selectedViewController{
//            view.subviews.forEach({ vu in
//                print(vu)
//                if vu.tag == 100 {
//                    vu.removeFromSuperview()
//                }
//            })
//        }
    }
    
    
}

@available(iOS 13.0, *)
extension TabbarViewController: UITabBarControllerDelegate{
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        if viewController is AddVC {

            showAddView()
            return false
        } else {
            addTaskView?.removeFromSuperview()
            
            return true
        }
    }
    
    
}
