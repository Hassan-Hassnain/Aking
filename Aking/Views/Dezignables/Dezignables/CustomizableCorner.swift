//
//  CustomizableCorner.swift
//  Pods
//
//  Created by Daniel van Hoesel on 26-02-16.
//
//

import UIKit

public protocol CustomizableCorner {
  var cornerRadius: CGFloat { get set }
  var cornerCircle: Bool { get set }
}

public extension CustomizableCorner where Self: UIView {
    func setupCorner() {
    let cornerRadius: CGFloat
    if self.cornerCircle {
      cornerRadius = self.frame.size.height / 2
    } else {
      cornerRadius = self.cornerRadius
    }
    
    if cornerRadius.isNaN || cornerRadius <= 0 {
      return
    }
    
    self.layer.cornerRadius = cornerRadius
  }
}
