//
//  AddCheckListVC.swift
//  Aking
//
//  Created by Usama Sadiq on 4/17/20.
//  Copyright © 2020 Usama Sadiq. All rights reserved.
//

import UIKit

class AddCheckListVC: UIViewController {

   @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var titleTextView: UITextView!
    
    var items: Int = 1
    var checkListItem = CheckListItem()
    
        override func viewDidLoad() {
            super.viewDidLoad()
            
            collectionView.delegate = self
            collectionView.dataSource = self
            
            tableView.delegate = self
            tableView.dataSource = self
        }
        
    @IBAction func addNewItemButtonTapped(_ sender: Any) {
        items += 1
        tableView.reloadData()
    }
    @IBAction func addTaskButtonTapped(_ sender: Any) {
        if let text = titleTextView.text { checkListItem.description = text}
        
        for x in 0..<items {
            let indexPath = IndexPath(row: x, section: 0)
            let cell:AddCheckListTableViewCell = tableView.cellForRow(at: indexPath) as! AddCheckListTableViewCell

            if let title = cell.itemTitleTF.text {
                checkListItem.items.append(Item(title: title, status: false))
            }
        }
        
        print(checkListItem)
    }
        
        
        
    }

extension AddCheckListVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        items
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell") as! AddCheckListTableViewCell
        cell.checkBoxView.layer.cornerRadius = 2
        cell.itemTitleTF.becomeFirstResponder()
        return cell
    }
    
    
    
}

    extension AddCheckListVC: UICollectionViewDataSource, UICollectionViewDelegate {
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            20
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CVC_Color_Chooser", for: indexPath) as! AddNoteCollectionViewCell
            cell.colorView.backgroundColor = .random
            cell.colorView.layer.cornerRadius = 5
            
            return cell
        }
        
        func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            let cell = collectionView.cellForItem(at: indexPath) as! AddNoteCollectionViewCell
            
            checkListItem.color = cell.colorView.backgroundColor!
            print(cell.colorView.backgroundColor!)
            
        }
        
    }


