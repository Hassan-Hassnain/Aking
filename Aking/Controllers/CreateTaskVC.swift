//
//  CreateTaskVC.swift
//  Aking
//
//  Created by Usama Sadiq on 4/14/20.
//  Copyright © 2020 Usama Sadiq. All rights reserved.
//

import UIKit

class CreateTaskVC: UIViewController {
    
    
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var memberCollectionView: UICollectionView!
    @IBOutlet weak var selectionTableView: UITableView!
    @IBOutlet weak var selectionTVHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var anyTimeButton: UIButton!
    //For Assignee
    @IBOutlet weak var assigneeImageView: CustomizableImageView!
    @IBOutlet weak var assigneeNameLabel: UILabel!
    @IBOutlet weak var assigneeImageViewWidthConstraint: NSLayoutConstraint!
    //In Project
    @IBOutlet weak var projectImageView: CustomizableImageView!
    @IBOutlet weak var projectNameLabel: UILabel!
    
    var datePickerView = DatePickerView()
    var assigneeName: String? = nil
    var assigneeImage: UIImage? = nil
    var projectName: String? = nil
    var projectImage: UIImage? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateNavBarAppearance()
        tabBarController?.tabBar.isHidden = true
        
        selectionTVHeightConstraint.constant = 0
        
        setupProject(name: projectName, image: projectImage)
        setupAssignee(name: assigneeName, image: assigneeImage)
        
        memberCollectionView.delegate = self
        memberCollectionView.dataSource = self
        selectionTableView.delegate = self
        selectionTableView.dataSource = self
        
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
    
    @IBAction func assigneeButtonTapped(_ sender: Any) {
        selectionTVHeightConstraint.constant = 649
    }
    @IBAction func projectButtonTapped(_ sender: Any) {
        print("project button tapped")
    }
    
    func setupAssignee(name: String?, image: UIImage?){
        if name == nil {
            assigneeNameLabel.text = "Assignee"
        } else {
            assigneeNameLabel.text = name
        }
        if image == nil {
            assigneeImageView.isHidden = true
            assigneeImageViewWidthConstraint.constant = 0
        } else {
            assigneeImageView.image = image
            assigneeImageView.isHidden = false
            assigneeImageViewWidthConstraint.constant = 44
            loadViewIfNeeded()
        }
        
    }
    
    func setupProject(name: String?, image: UIImage?){
        if name == nil {
            projectNameLabel.text = "Project"
        } else {
            projectNameLabel.text = name
        }
        if image == nil {
            projectImageView.isHidden = true
            projectImageView.widthAnchor.constraint(equalToConstant: 5).isActive = true
        } else {
            projectImageView.image = image
            projectImageView.isHidden = false
            projectImageView.widthAnchor.constraint(equalToConstant: 44).isActive = true
        }
        
    }
    
    
}

extension CreateTaskVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return people.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: SelectionTVCell.className) as! SelectionTVCell
        cell.configure(assginee: people[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let name = people[indexPath.row].name
        let image = people[indexPath.row].avator
        setupAssignee(name: name, image: image)
        selectionTVHeightConstraint.constant = 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 52
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
