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
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        GDataService.instance.getAllCheckList { (result) in
            if let result = result {self.checkLists = result}
        }
    }
    
    
    
}

extension QuickVC: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return checkLists.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "QuickNoteTableViewCell") as! QuickNoteTableViewCell
        cell.configure(checkList: self.checkLists[indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    
}




