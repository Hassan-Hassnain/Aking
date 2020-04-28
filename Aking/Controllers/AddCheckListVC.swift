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
    @IBOutlet weak var addNewItemButton: UIButton!
    @IBOutlet weak var containerViewHeightConstraint: NSLayoutConstraint!
    
    var itemsCount: Int = 1
    var checkListItem = CheckListItem()
    enum Mode {case addNote, addCheckList}
    var viewMode: Mode = .addCheckList
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        tabBarController?.tabBar.isHidden = true
        if viewMode == .addNote {
            tableView.isHidden = true
            addNewItemButton.isHidden = true
            containerViewHeightConstraint.constant = 468
            tableView.heightAnchor.constraint(equalToConstant: 0).isActive = true
            addNewItemButton.heightAnchor.constraint(equalToConstant: 0).isActive = true
        } else {
            tableView.isHidden = false
            addNewItemButton.isHidden = false
            containerViewHeightConstraint.constant = 662
            tableView.heightAnchor.constraint(equalToConstant: 247.5).isActive = true
            addNewItemButton.heightAnchor.constraint(equalToConstant: 37.5).isActive = true
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        tabBarController?.tabBar.isHidden = false
    }
    
    @IBAction func backButtonTapped(_ sender: Any) {
        tabBarController?.tabBar.isHidden = false
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func addNewItemButtonTapped(_ sender: Any) {
        itemsCount += 1
        tableView.reloadData()
    }
    
    @IBAction func addTaskButtonTapped(_ sender: Any) {
        if let text = titleTextView.text { checkListItem.note.description = text}
        
        for x in 0..<itemsCount {
            let indexPath = IndexPath(row: x, section: 0)
            let cell = tableView.cellForRow(at: indexPath) as! AddCheckListTableViewCell
            
            if let title = cell.itemTitleTF.text {
                if !title.isEmpty {
                    checkListItem.items.append(Item(title: title, status: false))
                }
            }
        }
        DataService.instance.uploadCheckList(withCheckList: checkListItem) { (succes) in
            print("CheckList upload successfully")
        }
        tabBarController?.tabBar.isHidden = false
        navigationController?.popViewController(animated: true)
    }
    
}

extension AddCheckListVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        itemsCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AddCheckListTableViewCell.className) as! AddCheckListTableViewCell
        cell.checkBoxView.layer.cornerRadius = 2
        cell.itemTitleTF.becomeFirstResponder()
        return cell
    }
    
}

extension AddCheckListVC: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        DataService.instance.colors.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AddNoteCollectionViewCell.className, for: indexPath) as! AddNoteCollectionViewCell
        cell.colorView.backgroundColor = DataService.instance.colors[indexPath.row]
        cell.colorView.layer.cornerRadius = 5
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! AddNoteCollectionViewCell
        
        checkListItem.note.color = cell.colorView.backgroundColor!
        
    }
    
}


