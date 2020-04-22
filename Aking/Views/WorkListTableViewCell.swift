//
//  WorkListTableViewCell.swift
//  Aking
//
//  Created by Usama Sadiq on 4/17/20.
//  Copyright © 2020 Usama Sadiq. All rights reserved.
//

import UIKit

class WorkListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var completionImageView: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var colorView: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        contentView.addShadow()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func configure(task: Task) {
//        self.title.text = task.title
//        self.time.text = task.dueDate
        self.colorView.backgroundColor = task.color
        if task.status == .done {
            self.completionImageView.image = UIImage(named: "TaskSign-Done")
            self.title.attributedText = myAttributedString(text: task.title,applyAtrribute: true)
            self.title.textColor = UIColor.lightGray
            self.time.attributedText = myAttributedString(text: task.dueDate,applyAtrribute: true)
            self.time.textColor = UIColor.lightGray
        } else {
            self.completionImageView.image = UIImage(named: "TaskSign-Pending")
            self.title.attributedText = myAttributedString(text: task.title,applyAtrribute: false)
            self.title.textColor = UIColor.black
            self.time.attributedText = myAttributedString(text: task.dueDate,applyAtrribute: false)
            self.time.textColor = UIColor.black
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
