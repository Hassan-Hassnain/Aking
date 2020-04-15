//
//  CustomizableBorder.swift
//  Pods
//
//  Created by Daniel van Hoesel on 26-02-16.
//
//

import UIKit

public protocol CustomizableBorder {
  var borderWidth: CGFloat { get set }
  var borderColor: UIColor? { get set }
  var borderTop: Bool { get set }
  var borderBottom: Bool { get set }
  var borderLeft: Bool { get set }
  var borderRight: Bool { get set }
  var borderScaleCorrection: Bool { get set }
}

public extension CustomizableBorder where Self: UIView {
    func setupBorder() {
    if self.borderWidth.isNaN || self.borderWidth <= 0 || self.borderColor == nil {
      return
    }
    
    self.removeExistingBorderLayer()
    self.createBorderLayer()
    self.setupView()
  }
  
  fileprivate func removeExistingBorderLayer() {
    self.layer.sublayers?.forEach({ layer in
      if layer.name == "CustomizableBorderLayer" {
        layer.removeFromSuperlayer()
      }
    })
  }
  
  fileprivate func createBorderLayer() {
    let borderLayer = CALayer()
    borderLayer.name = "CustomizableBorderLayer"
    borderLayer.borderWidth = self.scaledValue(self.borderWidth)
    borderLayer.borderColor = self.borderColor!.cgColor
    
    var frame = self.bounds
    
    if !self.borderLeft {
      frame.origin.x -= 1000
      frame.size.width += 1000
    }
    
    if !self.borderTop {
      frame.origin.y -= 1000
      frame.size.height += 1000
    }
    
    if !self.borderBottom {
      frame.size.height += 1000
    }
    
    if !self.borderRight {
      frame.size.width += 1000
    }
    
    borderLayer.frame = frame
    borderLayer.cornerRadius = self.layer.cornerRadius
    self.layer.addSublayer(borderLayer)
  }
  
  fileprivate func setupView() {
    self.clipsToBounds = true
  }
  
  fileprivate func scaledValue(_ value: CGFloat) -> CGFloat {
    return self.borderScaleCorrection ? value / UIScreen.main.scale : value
  }
}
