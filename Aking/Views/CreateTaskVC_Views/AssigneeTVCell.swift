//
//  AssigneeTVCell.swift
//  Aking
//
//  Created by Usama Sadiq on 4/15/20.
//  Copyright © 2020 Usama Sadiq. All rights reserved.
//

import UIKit

class AssigneeTVCell: UITableViewCell {
    
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var avatorImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        containerView.layer.cornerRadius = containerView.frame.size.height/2
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func configure(assignee: Assignee){
        avatorImageView.image = assignee.avator
        nameLabel.text = assignee.name
    }
    
}
