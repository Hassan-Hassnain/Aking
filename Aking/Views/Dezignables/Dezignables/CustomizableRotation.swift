//
//  CustomizableRotation.swift
//  Pods
//
//  Created by Daniel van Hoesel on 26-02-16.
//
//

import UIKit
import Darwin

// Can not previewed in Interface Builder
public protocol CustomizableRotation {
  var rotation: CGFloat { get set }
}

public extension CustomizableRotation where Self: UIView {
    func setupRotation() {
    if self.rotation.isNaN || self.rotation < -360 || self.rotation > 360 {
      return
    }
    
    self.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi) * self.rotation / 180)
  }
}
