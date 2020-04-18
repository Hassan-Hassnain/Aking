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
        self.title.text = task.title
        self.time.text = task.dueDate
        self.colorView.backgroundColor = task.color
        if task.status == .done {
            self.completionImageView.image = UIImage(named: "TaskSign-Done")
            self.title.attributedText = strikeThrough(text: task.title)
            self.title.textColor = UIColor.lightGray
            self.time.attributedText = strikeThrough(text: task.dueDate)
            self.time.textColor = UIColor.lightGray
        } else {
            self.completionImageView.image = UIImage(named: "TaskSign-Pending")
        }
        
    }
    
    
    func strikeThrough(text: String)->NSAttributedString {
        let attributeString =  NSMutableAttributedString(string: text)
        attributeString.addAttribute(
            NSAttributedString.Key.strikethroughStyle,
            value: NSUnderlineStyle.single.rawValue,
            range: NSMakeRange(0, attributeString.length)
        )
        return attributeString
    }
    
}
