//
//  ItemView.swift
//  Aking
//
//  Created by Usama Sadiq on 4/17/20.
//  Copyright © 2020 Usama Sadiq. All rights reserved.
//

import UIKit


class ItemView: UIView {

    let XIB_NAME = ItemView.className

    @IBOutlet var contentView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var checkBoxView: CustomizableView!
        
    var isChecked: Bool = false {
        didSet {
            updateCheckBox()
            UserDefaults.standard.set(self.tag, forKey: "TAG")
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "ItemStatusChanged"), object: nil)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func commonInit() {
        Bundle.main.loadNibNamed(XIB_NAME, owner: self, options: nil)
        contentView.fixInView(self)
        let tap =  UITapGestureRecognizer(target: self, action: #selector(updateIsCheckedValue))
        checkBoxView.addGestureRecognizer(tap)
    }
    
    @objc func updateIsCheckedValue(){
        if isChecked {
            isChecked = false
        } else {
            isChecked = true
        }
    }
    
    func updateCheckBox (){
        let text = titleLabel.text!
            if isChecked {
                checkBoxView.backgroundColor = #colorLiteral(red: 0.6323310137, green: 0.6328232288, blue: 0.632407248, alpha: 1)
                titleLabel.attributedText = myAttributedString(text: text, applyAtrribute: true)
            } else {
                checkBoxView.backgroundColor = #colorLiteral(red: 0.9658892751, green: 0.9697455764, blue: 0.9658194184, alpha: 1)
                titleLabel.attributedText =  myAttributedString(text: text, applyAtrribute: false)
            }
        
    }
    
    func myAttributedString(text: String,applyAtrribute: Bool)->NSAttributedString {
           let attributeString =  NSMutableAttributedString(string: text)
           attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: NSUnderlineStyle.single.rawValue,range: NSMakeRange(0, attributeString.length)
           )
           let removedAttributString = NSMutableAttributedString(string: text)
               removedAttributString.removeAttribute(NSAttributedString.Key.strikethroughStyle, range: NSMakeRange(0, attributeString.length))
           
           return applyAtrribute ? attributeString : removedAttributString
       }
}
