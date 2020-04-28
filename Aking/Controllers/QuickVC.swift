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
    var x = 0, y = 0
    @objc func itemStatusChanged() {
        
        x = 0
        y = 0
        
        for itemsList in checkListItemViews {
            y = 0
            for item in itemsList {
                if x < checkLists.count && y < checkLists[x].items.count{
                    let chListItem = checkLists[x].items[y]
                    if chListItem.status != item.isChecked {
                        print("x: \(x), y \(y)")
                        print("checkListItem: \(checkLists[x].items[y].title), \(checkLists[x].items[y].status) , item: \(String(describing: item.titleLabel.text)), \(item.isChecked)" )
                        print(checkLists[x])
                        //                        updateCheckListValue(checkList: checkLists[x], withStatus: item.isChecked)
                        return
                    }
                    y += 1
                }
                
            }
            x += 1
        }
        
    }
    
    func updateCheckListValue(checkList: CheckListItem, withStatus status: Bool) {
        var cl = checkLists[x]
        cl.items[y].status = status
        DataService.instance.updateCheckList(withCheckList: cl) { (success) in
            print("CheckList updated")
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
            if self.state == nil { self.state = self.checkListItemViews}
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    
}




