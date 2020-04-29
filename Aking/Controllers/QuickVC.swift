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
    var checkLists : [CheckListItem] = []
    var checkListItemViews: [[ItemView]] = []
    var tagNumber: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        DataService.instance.getAllCheckList { (result) in
            self.checkLists = []
            self.checkListItemViews = []
            if let result = result {self.checkLists = result}
            self.sortCheckListsByDate()
            self.tableView.reloadData()
            self.tagNumber = 0
        }
        NotificationCenter.default.addObserver(self, selector: #selector(itemStatusChanged), name: NSNotification.Name(rawValue: "ItemStatusChanged"), object: nil)
    }
    
    @objc func itemStatusChanged() {
        
        var x = 0, y = 0
        
        for list in checkListItemViews {
            y = 0
            for item in list {
                if item.tag == UserDefaults.standard.integer(forKey: "TAG") {
                    checkLists[x].items[y].status = !checkLists[x].items[y].status
                    DataService.instance.updateCheckList(withCheckList: checkLists[x]) { (success) in
                        return
                    }
                }
                y += 1
            }
            x += 1
        }
        
    }
    
    func sortCheckListsByDate(){
        checkLists = checkLists.sorted(by: {$0.date.compare($1.date) == .orderedAscending})
    }
}

extension QuickVC: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return checkLists.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: QuickNoteTableViewCell.className) as! QuickNoteTableViewCell
        cell.configure(checkList: self.checkLists[indexPath.row], withTagNumber: &tagNumber) { (itemViews) in
            self.checkListItemViews.append(itemViews)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
    
    
}




