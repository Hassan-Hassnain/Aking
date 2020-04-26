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
    var checkLists : [CheckListItem] = [] {didSet{tableView.reloadData()}}
    var checkListItemViews: [[ItemView]] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        DataService.instance.getAllCheckList { (result) in
            if let result = result {self.checkLists = result}
        }
        NotificationCenter.default.addObserver(self, selector: #selector(itemStatusChanged), name: NSNotification.Name(rawValue: "ItemStatusChanged"), object: nil)
    }
    
    @objc func itemStatusChanged() {
        
        var x = 0, y = 0
        
        for itemsList in checkListItemViews {
            for item in itemsList {
                print("Item Title: \(String(describing: item.titleLabel.text!)) and Status: \(item.isChecked)")
                y += 1
            }
            x += 1
        }
        
    }
    
    
}

extension QuickVC: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return checkLists.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: QuickNoteTableViewCell.className) as! QuickNoteTableViewCell
        cell.configure(checkList: self.checkLists[indexPath.row]) { (itemViews) in
            self.checkListItemViews.append(itemViews)
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let itemsList =  checkListItemViews[indexPath.row]
//        for item in itemsList {
//            print("Item Title: \(item.titleLabel.text as Any) and Status: \(item.isChecked)")
//        }
    }
    
    
}




