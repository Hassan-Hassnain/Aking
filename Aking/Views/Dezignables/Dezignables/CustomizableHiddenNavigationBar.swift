//
//  CustomizableHiddenNavigationBar.swift
//  Pods
//
//  Created by Daniel van Hoesel on 02-03-16.
//
//

import UIKit

public protocol CustomizableHiddenNavigationBar {
  var navigationBarHidden: Bool { get set }
}

public extension CustomizableHiddenNavigationBar where Self: UIViewController {
    func setupHiddenNavigationBar() {
    self.navigationController?.isNavigationBarHidden = self.navigationBarHidden
   // self.automaticallyAdjustsScrollViewInsets = !self.navigationBarHidden
  }
  
    func resetHiddenNavigationBar() {
    self.navigationController?.isNavigationBarHidden = false
   // self.automaticallyAdjustsScrollViewInsets = true
  }
}
