//
//  ViewTaskVC.swift
//  Aking
//
//  Created by Usama Sadiq on 4/16/20.
//  Copyright © 2020 Usama Sadiq. All rights reserved.
//

import UIKit

class ViewTaskVC: UIViewController {
    
    @IBOutlet weak var membersCollectionView: UICollectionView!
    @IBOutlet weak var additionalDetailView: UIView!
    @IBOutlet weak var additionalDetailViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var commentButton: UIStackView!
    @IBOutlet weak var commentsTableView: UITableView!
    
    @IBOutlet weak var taskTitleLabel: UILabel!
    @IBOutlet weak var assigneeLabel: UILabel!
    @IBOutlet weak var dueDateLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var tagButton: CustomizableButton!
    
    var settingView: UIView?
    var currentTask = Task(id: "nil", title: "", assigneeName: "", projectName: "", dueDate: "", description: "", members: [], tag: "", color: .clear, status: .pending)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBarController?.tabBar.isHidden = true
        navigationController?.navigationBar.isHidden = true
        
        hideAdditionDetails()
        createSettingView()
        commentsTableView.dataSource = self
        commentsTableView.delegate = self
        
        taskTitleLabel.text = currentTask.title
        assigneeLabel.text = currentTask.assigneeName
        dueDateLabel.text = currentTask.dueDate
        tagButton.setTitle(currentTask.tag, for: .normal)
        descriptionLabel.text = currentTask.description
    }
    
    func initTask(task: Task) {
        self.currentTask = task
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        tabBarController?.tabBar.isHidden = false
        navigationController?.navigationBar.isHidden = false
    }
    
    @IBAction func closeButton(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func commentButtonTapped(_ sender: Any) {
        showAdditionalDetails()
        commentButton.isHidden = true
        tabBarController?.tabBar.isHidden  = false    }
    @IBAction func completeTaskButtonTapped(_ sender: Any) {
        commentButton.isHidden = false
        currentTask.status = .done
        GDataService.instance.updateTask(withTask: currentTask) { (success) in
            if success {
                self.navigationController?.popViewController(animated: true)                
            }
        }
    }
    @IBAction func settingButtonTapped(_ sender: Any) {
        if let settingView = settingView{
            if settingView.isHidden {
                settingView.isHidden = false
            } else {
                settingView.isHidden = true
            }
        }
    }
    
    func hideAdditionDetails(){
        additionalDetailViewHeightConstraint.constant = 0
        additionalDetailView.isHidden = true
    }
    func showAdditionalDetails() {
        additionalDetailViewHeightConstraint.constant = 553
        additionalDetailView.isHidden = false
    }
    func createSettingView(){
        settingView = UIView(frame: self.view.frame)
        settingView?.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.2904169284)
        let trailingConstant: CGFloat = 31
        let width: CGFloat = 228.0
        let height: CGFloat = 130.0
        let x: CGFloat = self.view.frame.size.width - (width + trailingConstant)
        let y: CGFloat = 114.0
        let optionsView = TaskFilterView(frame: CGRect(x: x, y: y, width: width, height: height))
        optionsView.allTaskImageView.isHidden = true
        optionsView.completedTaskImageView.isHidden = true
        optionsView.incompleteTaskImageView.isHidden = true
        optionsView.topButton.setTitle("Add to Project", for: .normal)
        optionsView.centerButton.setTitle("Add Member", for: .normal)
        optionsView.bottomButton.setTitle("Delete Task", for: .normal)
        optionsView.delegate = self
        settingView?.addSubview(optionsView)
        settingView?.isHidden = true
        
        
        self.view.addSubview(settingView!)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(settingViewGestureSelector))
        settingView?.addGestureRecognizer(tapGesture)
        
    }
    @objc func settingViewGestureSelector(){
        settingView?.isHidden = true
    }
}

extension ViewTaskVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellWithText = tableView.dequeueReusableCell(withIdentifier: "TVTextCell")
        let cellWithImage = tableView.dequeueReusableCell(withIdentifier: "TVImageCell")
        
        if indexPath.row != 4 {
            return cellWithText!
        } else {
            return cellWithImage!
        }
        
    }
    
    
}
//MARK: - SettingView delegate
extension ViewTaskVC: TaskFilterViewDelegate{
    func incompleteTasksButtonDidTapped() {
        let vc = storyboard?.instantiateViewController(identifier: ProjecstVC.className) as! ProjecstVC
        vc.isLoadedForProjectSelection = true
        navigationController?.pushViewController(vc, animated: true)
        
        settingView!.isHidden = true
        
    }
    
    func completedTaskButtonDidTapped() {
        print("Completed Task")
        settingView!.isHidden = true
    }
    
    func allTasksButtonDidTapped() {
        print("All Task")
        settingView!.isHidden = true
    }
    
    
}
