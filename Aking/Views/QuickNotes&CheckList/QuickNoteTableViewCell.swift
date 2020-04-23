//
//  QuickNoteTableViewCell.swift
//  Aking
//
//  Created by Usama Sadiq on 4/16/20.
//  Copyright © 2020 Usama Sadiq. All rights reserved.
//

import UIKit

class QuickNoteTableViewCell: UITableViewCell {

    @IBOutlet weak var colorView: UIView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var itemsStackView: UIStackView!
    
    var items: [Item] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(checkList: CheckListItem) {
        self.descriptionLabel.text = checkList.note.description
        self.colorView.backgroundColor = checkList.note.color
        addCheckListItemsIfAvailable(items: checkList.items)
    }

    fileprivate func addCheckListItemsIfAvailable(items: [Item]) {
        
        for subview in self.itemsStackView.subviews {
            if (subview.tag == 100) {
                subview.removeFromSuperview()
            }
        }
        
        if items.count > 0 {
            if !items.isEmpty {
                items.forEach { (item) in
                    let itemView = ItemView(frame: CGRect(x: 48, y: 0, width: 200, height: 28.5))
                    itemView.tag = 100
                    itemView.titleLabel.text = item.title
                    itemView.isChecked = item.status
                    self.itemsStackView.addArrangedSubview(itemView)
                }
            }
            
        }
    }
}
