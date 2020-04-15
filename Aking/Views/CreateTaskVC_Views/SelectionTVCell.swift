//
//  SelectionTVCell.swift
//  Aking
//
//  Created by Usama Sadiq on 4/15/20.
//  Copyright © 2020 Usama Sadiq. All rights reserved.
//

import UIKit

class SelectionTVCell: UITableViewCell {

    @IBOutlet weak var avatorImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        avatorImageView.layer.cornerRadius = 22
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(assginee: Assignee) {
        self.avatorImageView.image = assginee.avator
        self.nameLabel.text = assginee.name
        self.emailLabel.text = assginee.email
    }

}
