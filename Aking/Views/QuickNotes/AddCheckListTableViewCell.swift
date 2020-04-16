//
//  AddCheckListTableViewCell.swift
//  Aking
//
//  Created by Usama Sadiq on 4/17/20.
//  Copyright © 2020 Usama Sadiq. All rights reserved.
//

import UIKit

class AddCheckListTableViewCell: UITableViewCell, UITextFieldDelegate {

    @IBOutlet weak var checkBoxView: CustomizableView!
    @IBOutlet weak var itemTitleTF: UITextField!
    
    var isChecked: Bool = false {
        didSet {
            updateCheckBox()
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        itemTitleTF.delegate = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func updateCheckBox (){
        if isChecked {
            checkBoxView.backgroundColor = #colorLiteral(red: 0.9658892751, green: 0.9697455764, blue: 0.9658194184, alpha: 1)
        } else {
            checkBoxView.backgroundColor = #colorLiteral(red: 0.6323310137, green: 0.6328232288, blue: 0.632407248, alpha: 1)
        }
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.resignFirstResponder()
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
}

