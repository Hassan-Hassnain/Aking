//
//  CustomizableTextField.swift
//  UIViewSubClasses Testing
//
//  Created by Usama Sadiq on 3/27/20.
//  Copyright © 2020 Usama Sadiq. All rights reserved.
//


import UIKit

class CustomizableTextField: UITextField, CustomizableBorder, CustomizableCorner, CustomizableBackground,  CustomizableShadow {

    var LeftViewButton: UIButton?
    var RighttViewButton: UIButton?

    @IBInspectable open var backgroundFillColor: UIColor? = nil {
      didSet {
        self.setupBackground()
      }
    }
    
    @IBInspectable open var backgroundGradientStartColor: UIColor? = nil {
      didSet {
        self.setupBackground()
      }
    }
    
    @IBInspectable open var backgroundGradientStopColor: UIColor? = nil {
      didSet {
        self.setupBackground()
      }
    }
    
    @IBInspectable open var backgroundGradientStartPoint: CGPoint = CGPoint.zero {
      didSet {
        self.setupBackground()
      }
    }
    
    @IBInspectable open var backgroundGradientStopPoint: CGPoint = CGPoint.zero {
      didSet {
        self.setupBackground()
      }
    }
    
      @IBInspectable open var borderWidth: CGFloat = CGFloat.nan {
        didSet {
          self.setupBorder()
        }
      }

      @IBInspectable open var borderColor: UIColor? = nil {
        didSet {
          self.setupBorder()
        }
      }

      @IBInspectable open var borderTop: Bool = false {
        didSet {
          self.setupBorder()
        }
      }

      @IBInspectable open var borderBottom: Bool = false {
        didSet {
          self.setupBorder()
        }
      }

      @IBInspectable open var borderLeft: Bool = false {
        didSet {
          self.setupBorder()
        }
      }

      @IBInspectable open var borderRight: Bool = false {
        didSet {
          self.setupBorder()
        }
      }

      @IBInspectable open var borderScaleCorrection: Bool = false {
        didSet {
          self.setupBorder()
        }
      }

      @IBInspectable open var cornerRadius: CGFloat = CGFloat.nan {
        didSet {
          self.setupCorner()
        }
      }

      @IBInspectable open var cornerCircle: Bool = false {
        didSet {
          self.setupCorner()
        }
      }

      @IBInspectable open var boxShadowColor: UIColor? = nil {
        didSet {
          self.setupShadow()
        }
      }

      @IBInspectable open var boxShadowRadius: CGFloat = CGFloat.nan {
        didSet {
          self.setupShadow()
        }
      }

      @IBInspectable open var boxShadowOpacity: CGFloat = CGFloat.nan {
        didSet {
          self.setupShadow()
        }
      }

      @IBInspectable open var boxShadowOffset: CGPoint = CGPoint(x: CGFloat.nan, y: CGFloat.nan) {
        didSet {
          self.setupShadow()
        }
      }

      open override func layoutSubviews() {
        super.layoutSubviews()
        self.setupBorder()
        self.setupCorner()
      }

// MARK: - TextField Left View
    
    @IBInspectable var leftImage: UIImage? {
        didSet {
            updateView()
        }
    }
    
    @IBInspectable var leftPadding: CGFloat = 0 {
        didSet {
            updateView()
        }
    }
// MARK: - TextField Right View
    @IBInspectable var rightImage: UIImage? {
        didSet {
            updateView()
        }
    }
    
    @IBInspectable var rightPadding: CGFloat = 0 {
        didSet {
            updateView()
        }
    }
    
    
    private var _isRightViewVisible: Bool = true
    var isRightViewVisible: Bool {
        get {
            return _isRightViewVisible
        }
        set {
            _isRightViewVisible = newValue
            updateView()
        }
    }
    
    
     //MARK: - PLACE HOLDER AND  EDITING PADDING
     var padding = UIEdgeInsets()
     
     @IBInspectable var L_textPadding: CGFloat = 0 {
         didSet {
             updatePadding()
             
         }
     }
     @IBInspectable var R_textPadding: CGFloat = 0 {
         didSet {
             updatePadding()
             
         }
     }
    

    private func updateView() {
        setLeftImage()
        setRightImage()
    
        
        // Placeholder text color
        attributedPlaceholder = NSAttributedString(string: placeholder != nil ?
            placeholder! :
            "", attributes:[NSAttributedString.Key.foregroundColor: tintColor as Any])
    }
    
    func setLeftImage() {
        leftViewMode = UITextField.ViewMode.always
        var view: UIView
        
        if let image = leftImage {
            let leftButton = UIButton(frame: CGRect(x: leftPadding, y: 0, width: 20, height: 20))
            leftButton.setImage(image, for: .normal)
            // Note: In order for your image to use the tint color, you have to select the image in the Assets.xcassets and change the "Render As" property to "Template Image".
            leftButton.tintColor = tintColor
            
            var width = leftButton.frame.width + leftPadding
            
            if borderStyle == UITextField.BorderStyle.none || borderStyle == UITextField.BorderStyle.line {
                width += 5
            }
            LeftViewButton = leftButton
            view = UIView(frame: CGRect(x: 0, y: 0, width: width, height: 20))
            view.addSubview(leftButton)
        } else {
            view = UIView(frame: CGRect(x: 0, y: 0, width: leftPadding, height: 20))
        }
        
        leftView = view
    }
    
    func setRightImage() {
        rightViewMode = UITextField.ViewMode.always
        
        var view: UIView
        
        if let image = rightImage, isRightViewVisible {
            let rightButton = UIButton(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
            rightButton.setImage(image, for: .normal)
            // Note: In order for your image to use the tint color, you have to select the image in the Assets.xcassets and change the "Render As" property to "Template Image".
            rightButton.tintColor = tintColor
            
            var width = rightButton.frame.width + rightPadding
            
            if borderStyle == UITextField.BorderStyle.none || borderStyle == UITextField.BorderStyle.line {
                width += 5
            }
            RighttViewButton = rightButton
            view = UIView(frame: CGRect(x: 0, y: 0, width: width, height: 20))
            view.addSubview(rightButton)
            
        } else {
            view = UIView(frame: CGRect(x: 0, y: 0, width: rightPadding, height: 20))
        }
        
        rightView = view
    }
    
 //MARK: - PLACE HOLDER AND TEXT PADDING FUNCTIONS
    
    
    func updatePadding() {
        let textLeftPadding = leftPadding + L_textPadding
        padding = UIEdgeInsets(top: 0, left: textLeftPadding, bottom: 0, right: 5)
    }

    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
}

