//
//  CustomizableBackground.swift
//  Pods
//
//  Created by Daniel van Hoesel on 28-02-16.
//
//

import UIKit
let COLOR_LAYER = "CustomizableBackgroundLayer"
public protocol CustomizableBackground {
  var backgroundFillColor: UIColor? { get set }
  var backgroundGradientStartColor: UIColor? { get set }
  var backgroundGradientStopColor: UIColor? { get set }
  var backgroundGradientStartPoint: CGPoint { get set }
  var backgroundGradientStopPoint: CGPoint { get set }
}

public extension CustomizableBackground where Self: UIView {
    
    
    
    func setupBackground() {
    self.removeExistingBackgroundView()
    
    if self.backgroundFillColor != nil {
      self.createBackgroundFillLayer()
    } else if self.backgroundGradientStartColor != nil && self.backgroundGradientStopColor != nil {
      self.createBackgroundGradientLayer()
    }
  }
  
  fileprivate func removeExistingBackgroundView() {
    
        if let layers = self.layer.sublayers {
            if layers.count > 1 {
                for layer in layers {
                    if layer.name == COLOR_LAYER {
                        layer.removeFromSuperlayer()
                    }
                }
    
                print("Color Layer removed \(layers.count)")
            }
        }
    
//    self.subviews.forEach({ subview in
//      if subview is BackgroundView {
//        subview.removeFromSuperview()
//      }
//    })
  }
  
  fileprivate func createBackgroundFillLayer() {
    
    
    
    let view = BackgroundView(frame: self.bounds)
    let backgroundLayer = CALayer()
    backgroundLayer.name = COLOR_LAYER
    backgroundLayer.frame = self.bounds
    backgroundLayer.cornerRadius = self.layer.cornerRadius
    backgroundLayer.backgroundColor = self.backgroundFillColor!.cgColor
    view.layer.addSublayer(backgroundLayer)
    
    var present: Bool = false
    
        if let layers = self.layer.sublayers {
            if layers.count > 1 {
                for layer in layers {
                    if layer.name == COLOR_LAYER {
                        present = true
                    }
                }
    
            }
        }
        if !present {
            self.layer.insertSublayer (backgroundLayer, at: 0)
        }
        self.clipsToBounds = true
    
    
        print(backgroundLayer.name!)
        print("Color Filled \(String(describing: self.layer.sublayers?.count))")

//
//    self.insertSubview(view, at: 0)
  }
  
  fileprivate func createBackgroundGradientLayer() {
    
    removeExistingBackgroundView()
    let gradientColors: [CGColor] = [backgroundGradientStartColor!.cgColor, backgroundGradientStopColor!.cgColor]
        let gradientLayer: CAGradientLayer = CAGradientLayer ()
        gradientLayer.colors = gradientColors
        gradientLayer.startPoint = backgroundGradientStartPoint
        gradientLayer.endPoint = backgroundGradientStopPoint
        gradientLayer.frame = self.bounds
        gradientLayer.name = COLOR_LAYER
    
        var present: Bool = false
    
        if let layers = self.layer.sublayers {
            if layers.count > 1 {
                for layer in layers {
                    if layer.name == COLOR_LAYER {
                        present = true
                    }
                }
    
            }
        }
        if !present {
            self.layer.insertSublayer (gradientLayer, at: 0)
        }
        self.clipsToBounds = true
    
    
        print(gradientLayer.name!)
        print("Gradient layer added \(String(describing: self.layer.sublayers?.count))")
    
    
    
//    let view = BackgroundView(frame: self.bounds)
//    let backgroundLayer = CAGradientLayer()
//    backgroundLayer.name = "CustomizableBackgroundLayer"
//    backgroundLayer.frame = self.bounds
//    backgroundLayer.cornerRadius = self.layer.cornerRadius
//    backgroundLayer.colors = [self.backgroundGradientStartColor!.cgColor, self.backgroundGradientStopColor!.cgColor]
//    backgroundLayer.startPoint = self.backgroundGradientStartPoint
//    backgroundLayer.endPoint = self.backgroundGradientStopPoint
//    view.layer.addSublayer(backgroundLayer)
//    self.insertSubview(view, at: 0)
  }
}

private class BackgroundView: UIView {
  
}

