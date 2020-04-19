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
        if isChecked {
            checkBoxView.backgroundColor = #colorLiteral(red: 0.6323310137, green: 0.6328232288, blue: 0.632407248, alpha: 1)
        } else {
            checkBoxView.backgroundColor = #colorLiteral(red: 0.9658892751, green: 0.9697455764, blue: 0.9658194184, alpha: 1)
        }
    }
}
