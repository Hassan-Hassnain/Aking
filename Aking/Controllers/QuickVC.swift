//
//  QuickVC.swift
//  Aking
//
//  Created by Usama Sadiq on 4/6/20.
//  Copyright © 2020 Usama Sadiq. All rights reserved.
//

import UIKit

class QuickVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
    }
    
    
     
}

extension QuickVC: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DataService.instance.checkListItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "QuickNoteTableViewCell") as! QuickNoteTableViewCell
        cell.descriptionLabel.text = DataService.instance.checkListItems[indexPath.row].note.description
        cell.colorView.backgroundColor = DataService.instance.checkListItems[indexPath.row].note.color
        
        addCheckListItemsIfAvailable(indexPath, cell)
        
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    fileprivate func addCheckListItemsIfAvailable(_ indexPath: IndexPath, _ cell: QuickNoteTableViewCell) {
        
        for subview in cell.itemsStackView.subviews {
            if (subview.tag == 100) {
                subview.removeFromSuperview()
            }
        }
        
        if DataService.instance.checkListItems[indexPath.row].items.count > 0 {
            let items = DataService.instance.checkListItems[indexPath.row].items
            if !items.isEmpty {
                items.forEach { (item) in
                    let itemView = ItemView(frame: CGRect(x: 48, y: 0, width: 200, height: 28.5))
                    itemView.tag = 100
                    itemView.titleLabel.text = item.title
                    itemView.isChecked = item.status
                    cell.itemsStackView.addArrangedSubview(itemView)
                }
            }
            
        }
    }
}


