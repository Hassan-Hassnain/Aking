//
//  MemberCVC.swift
//  Aking
//
//  Created by Usama Sadiq on 4/15/20.
//  Copyright © 2020 Usama Sadiq. All rights reserved.
//

import UIKit

class MemberCVC: UICollectionViewCell {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var anyoneLabel: UILabel!
    @IBOutlet weak var avator: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        containerView.layer.cornerRadius = containerView.frame.size.height/2
        print(containerView.frame.size.height/2)
    }

}
