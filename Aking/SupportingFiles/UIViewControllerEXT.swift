//
//  UIViewControllerEXT.swift
//  Aking
//
//  Created by Usama Sadiq on 4/15/20.
//  Copyright © 2020 Usama Sadiq. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func updateNavBarAppearance(color: UIColor, title: String?, tintColor: UIColor? = .white){
        if #available(iOS 13.0, *) {
            if  let navigationBar = navigationController?.navigationBar {
                let appearance = UINavigationBarAppearance()
                appearance.backgroundColor = color
                appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
                appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
                
                UINavigationBar.appearance().tintColor = tintColor!
                if let title = title { navigationItem.title = title}
                
                let barAppearence = UIBarButtonItemAppearance()
                
                barAppearence.normal.titleTextAttributes = [.foregroundColor: UIColor.white]
                appearance.buttonAppearance = barAppearence
                navigationBar.scrollEdgeAppearance = appearance
                navigationBar.compactAppearance = appearance
                navigationBar.standardAppearance = appearance
            }
            
        } else {
            UINavigationBar.appearance().tintColor = tintColor!
            UINavigationBar.appearance().barTintColor = color
            UINavigationBar.appearance().isTranslucent = false
            if let title = title { navigationItem.title = title}
        }
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
        guard let vc = storyboard?.instantiateViewController(withIdentifier: to) else {return}
        vc.modalPresentationStyle = .fullScreen
        if animate {
            presentDetail(vc)
        } else {
            self.present(vc, animated: false, completion: nil)
        }
    }
    func pushVC(viewController: String, animated: Bool) {
        guard let vc = storyboard?.instantiateViewController(withIdentifier: viewController) else {
            print("Failed to instantiate view controller with given identifier")
            return
        }
        navigationController?.pushViewController(vc, animated: animated)
    }
    func goTo(fromStoryboar sb: UIStoryboard, toVC to: String, animate: Bool) {
        let vc = sb.instantiateViewController(withIdentifier: to)
        vc.modalPresentationStyle = .fullScreen
        if animate {
            presentDetail(vc)
        } else {
            self.present(vc, animated: false, completion: nil)
        }
    }
}
