//
//  CreateTaskVC.swift
//  Aking
//
//  Created by Usama Sadiq on 4/14/20.
//  Copyright © 2020 Usama Sadiq. All rights reserved.
//

import UIKit

class CreateTaskVC: UIViewController {

    
    @IBOutlet weak var forTableView: UITableView!
    @IBOutlet weak var inTableView: UITableView!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var memberCollectionView: UICollectionView!
    @IBOutlet weak var selectionTableView: UITableView!
    @IBOutlet weak var selectionTVHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var anyTimeButton: UIButton!
    
    var datePickerView = DatePickerView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        updateNavBarAppearance()
        tabBarController?.tabBar.isHidden = true

        selectionTVHeightConstraint.constant = 0
        
        forTableView.dataSource = self
        inTableView.dataSource = self
        forTableView.delegate = self
        inTableView.delegate = self
        memberCollectionView.delegate = self
        memberCollectionView.dataSource = self
        selectionTableView.delegate = self
        selectionTableView.dataSource = self
        
        forTableView.regCell(cellName: AssigneeTVCell.className)
        inTableView.regCell(cellName: ProjectTVCell.className)
        memberCollectionView.regCell(cellName: MemberCVC.className)
        selectionTableView.regCell(cellName: SelectionTVCell.className)
        
        datePickerView = DatePickerView(frame: CGRect(x: 16, y: 227, width: 344, height: 397))
        datePickerView.center.x = self.view.center.x
        self.view.addSubview(datePickerView)
        datePickerView.isHidden = true
        datePickerView.delegate = self
        
    }
    @IBAction func attachmentButtonTapped(_ sender: Any) {
        
    }
    @IBAction func anytimeButtonTapped(_ sender: Any) {
        datePickerView.isHidden = false
        loadViewIfNeeded()
    }
    @IBAction func addTaskButtonTapped(_ sender: Any) {
    }
    


}

extension CreateTaskVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == forTableView {
            return 2
        } else if tableView == inTableView {
            return 2
        } else {
            return 13
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == forTableView {
            let cell = tableView.dequeueReusableCell(withIdentifier: AssigneeTVCell.className) as! AssigneeTVCell
            cell.avatorImageView.isHidden = true
            cell.avatorImageView.widthAnchor.constraint(equalToConstant: 0).isActive = true
            cell.nameLabel.text = "Assignee"
            return cell
        } else if tableView == inTableView {
            let cell = tableView.dequeueReusableCell(withIdentifier: ProjectTVCell.className) as! ProjectTVCell
            cell.projectName.text = "Project"
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: SelectionTVCell.className) as! SelectionTVCell
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == forTableView {
            print("For Table view \(indexPath.row)")
            if selectionTVHeightConstraint.constant == 0{
                selectionTVHeightConstraint.constant = 650
            }
        } else if tableView == inTableView {
            print("In Table view \(indexPath.row)")
        } else {
            print("This is selection Table View \(indexPath.row)")
            selectionTVHeightConstraint.constant = 0
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView == forTableView {
            return tableView.frame.size.height-1
        } else if tableView == inTableView {
            return tableView.frame.size.height-1
        } else {
            return 52
        }
    }
    
    
}

extension CreateTaskVC: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MemberCVC.className, for: indexPath) as! MemberCVC
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        return CGSize(width: (view.safeAreaLayoutGuide.layoutFrame.width), height: 30);
//        return CGSize(width: collectionView. preferredWidth, height: floor(preferredHeight))
    }
}
//MARK: - 
extension CreateTaskVC: DatePickerViewDelegate {
    func didDateSelectionCompleted(date: String) {
        self.datePickerView.isHidden = true
        self.anyTimeButton.setTitle(date, for: .normal)
    }
    
    
}
