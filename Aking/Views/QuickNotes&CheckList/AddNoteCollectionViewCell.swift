//
//  AddNoteCollectionViewCell.swift
//  Aking
//
//  Created by Usama Sadiq on 4/16/20.
//  Copyright © 2020 Usama Sadiq. All rights reserved.
//

import UIKit

class AddNoteCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var colorView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.colorView.layer.cornerRadius = 5
    }
    
    func configure(color: UIColor){
        self.contentView.backgroundColor = color
        
    }
    
}
