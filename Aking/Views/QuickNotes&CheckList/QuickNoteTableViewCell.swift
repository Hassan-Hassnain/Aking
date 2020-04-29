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
    
    func configure(checkList: CheckListItem, withTagNumber tag: inout Int, onCompletion: @escaping (_ itemsHandler: [ItemView]) -> ()){
        self.descriptionLabel.text = checkList.note.description
        self.colorView.backgroundColor = checkList.note.color
        let items = addCheckListItemsIfAvailable(items: checkList.items, withTagNumber: &tag)
        onCompletion(items)
    }
    
    fileprivate func addCheckListItemsIfAvailable(items: [Item], withTagNumber tag: inout Int) -> [ItemView]{
        
        removeAllItemViewsFromStackView()
        
        var itemsHandler: [ItemView] = []
        if items.count > 0 {
            if !items.isEmpty {
                items.forEach { (item) in
                    let itemView = ItemView(frame: CGRect(x: 48, y: 0, width: 200, height: 28.5))
                    itemView.tag = tag
                    itemView.titleLabel.text = item.title
                    itemView.isChecked = item.status
                    self.itemsStackView.addArrangedSubview(itemView)
                    itemsHandler.append(itemView)
                    tag += 1
                }
            }
            
        }
        return itemsHandler
    }
    
    func removeAllItemViewsFromStackView(){
        itemsStackView.subviews.forEach { (view) in
            view.removeFromSuperview()
        }
    }
}
