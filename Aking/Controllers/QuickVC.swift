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
    var state: [[ItemView]]?
    
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
            if self.state == nil { self.state = self.checkListItemViews}
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
    
    
}




