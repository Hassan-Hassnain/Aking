//
//  UIViewControllerEXT.swift
//  Aking
//
//  Created by Usama Sadiq on 4/15/20.
//  Copyright © 2020 Usama Sadiq. All rights reserved.
//

import UIKit

extension UIViewController {
    func updateNavBarAppearance(color: UIColor?, title: String?){
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        if let color = color {appearance.backgroundColor = color}
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        navigationItem.standardAppearance = appearance
        navigationItem.scrollEdgeAppearance = appearance
        navigationItem.compactAppearance = appearance
        if let title = title { navigationItem.title = title}
    }
    
    func presentDetail(_ viewControllerToPresent: UIViewController) {
        let transition = CATransition()
        transition.duration = 0.6
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromRight
        self.view.window?.layer.add(transition, forKey: kCATransition)
        
        present(viewControllerToPresent, animated: true, completion: nil)
    }
    func presentSecondary(_ viewControllerToPresent: UIViewController) {
        let transition = CATransition()
        transition.duration = 0.6
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromRight
        
        guard let presentedViewController = presentedViewController else {return}
        
        presentedViewController.dismiss(animated: false) {
            self.view.window?.layer.add(transition, forKey: kCATransition)
            self.present(viewControllerToPresent, animated: false, completion: nil)
        }
    }
    
    func dismissDetail() {
        let transition = CATransition()
        transition.duration = 0.6
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromLeft
        
        self.view.window?.layer.add(transition, forKey: kCATransition)
        
        dismiss(animated: false, completion: nil)
    }
    
    
    func goTo( toVC to: String, animate: Bool) {
        guard let vc = storyboard?.instantiateViewController(identifier: to) else {return}
        vc.modalPresentationStyle = .fullScreen
        if animate {
            presentDetail(vc)
        } else {
            self.present(vc, animated: false, completion: nil)
        }
    }
    func pushVC(viewController: String, animated: Bool) {
        guard let vc = storyboard?.instantiateViewController(identifier: viewController) else {
            print("Failed to instantiate view controller with given identifier")
            return
        }
        navigationController?.pushViewController(vc, animated: animated)
    }
    func goTo(fromStoryboar sb: UIStoryboard, toVC to: String, animate: Bool) {
        let vc = sb.instantiateViewController(identifier: to)
        vc.modalPresentationStyle = .fullScreen
        if animate {
            presentDetail(vc)
        } else {
            self.present(vc, animated: false, completion: nil)
        }
    }
}
