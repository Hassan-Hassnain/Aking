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
    var currentTask: Task? {didSet{loadViewWithCurrentTask()}}
    
//MARK: - Initalizers
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBarController?.tabBar.isHidden = true
        navigationController?.navigationBar.isHidden = true
        
        hideAdditionDetails()
        createSettingView()
        commentsTableView.dataSource = self
        commentsTableView.delegate = self
        
        tagButton.setTitle("", for: .normal)
  
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        tabBarController?.tabBar.isHidden = false
        navigationController?.navigationBar.isHidden = false
    }

//MARK: - @IBActions
    @IBAction func closeButton(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func commentButtonTapped(_ sender: Any) {
        showAdditionalDetails()
        commentButton.isHidden = true
        tabBarController?.tabBar.isHidden  = false
    }
    
    @IBAction func completeTaskButtonTapped(_ sender: Any) {
        commentButton.isHidden = false
        currentTask?.status = currentTask?.status == .done ? .pending: .done
        DataService.instance.updateTask(withTask: currentTask!) { (success) in
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

//MARK: - Helping Functions
    
    func loadViewWithCurrentTask() {
        if let currentTask = currentTask {
            taskTitleLabel.text = currentTask.title
            assigneeLabel.text = currentTask.assigneeName
            dueDateLabel.text = currentTask.dueDate
            tagButton.setTitle(currentTask.tag, for: .normal)
            descriptionLabel.text = currentTask.description
            tagButton.setTitle(" \(currentTask.projectName) ", for: .normal)
        }
    }
    
    func initTask(taskID: String) {
        DataService.instance.getAllTask { (tasks) in
            if let tasks = tasks {
                for task in tasks {
                    if task.id == taskID {
                        self.currentTask  = task
                        return
                    }
                }
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
        let optionsView = UIView.setupFilterView(caller: self.view)
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

//MARK: - TableView Delegate and Datasource
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
    func incompleteTasksButtonDidTapped() { //Add project
        let vc = storyboard?.instantiateViewController(withIdentifier: ProjecstVC.className) as! ProjecstVC
        vc.isLoadedForProjectSelection = true
        vc.task = currentTask
        settingView!.isHidden = true
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func completedTaskButtonDidTapped() {
        print("Completed Task")
        settingView!.isHidden = true
    }
    
    func allTasksButtonDidTapped() {
        DataService.instance.removeTask(taskId: currentTask!.id)
        settingView!.isHidden = true
    }
    
    
}



