//
//  CreateTaskVC.swift
//  Aking
//
//  Created by Usama Sadiq on 4/14/20.
//  Copyright © 2020 Usama Sadiq. All rights reserved.
//

import UIKit


enum TaskNature { case createTask, editingTask  }
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
    @IBOutlet weak var titleTF: UITextField!
    
    var datePickerView = DatePickerView()
    var assigneeName: String? = nil
    var assigneeImage: UIImage? = nil
    var projectName: String? = nil
    var projectImage: UIImage? = nil
    
    var taskNature: TaskNature = .createTask
    var task: Task?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateNavBarAppearance(color: #colorLiteral(red: 0.9568627451, green: 0.4392156863, blue: 0.4196078431, alpha: 1), title: "Work List")
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if taskNature == .editingTask {
            prepareTaskForEditing()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        tabBarController?.tabBar.isHidden = false
    }
    
    func initTask(task: Task) {
        self.task = task
        taskNature = .editingTask
    }
    
    @IBAction func backButtonTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func attachmentButtonTapped(_ sender: Any) {
        
    }
    @IBAction func anytimeButtonTapped(_ sender: Any) {
        datePickerView.isHidden = false
        loadViewIfNeeded()
    }
    @IBAction func addTaskButtonTapped(_ sender: Any) {
        if taskNature == .createTask {
            if let task = prepareTask() {
//                DataService.instance.tasks.append(task)
                
                GDataService.instance.uploadTask(withTask: task) { (success) in
                    success ? print("Task uploading success") : print("Task uploading failed")
                }
            } else { print("Failed to create new task")}
        } else {
            if let editedTask = prepareTask() {
                GDataService.instance.updateTask(withTask: editedTask) { (success) in
                    success ? print("Task uploading success") : print("Task uploading failed")
                }
            }        }
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func assigneeButtonTapped(_ sender: Any) {
        selectionTVHeightConstraint.constant = 649
    }
    
    @IBAction func projectButtonTapped(_ sender: Any) {
        
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
    
    func prepareTask()->Task? {
        var task: Task?
        guard let title = titleTF.text else { return nil }
        guard let assigneeName = assigneeNameLabel.text else { return nil }
        guard let dutDate =  (anyTimeButton.titleLabel?.text)?.getFormattedDateString() else {
            return nil }
        guard let description = descriptionTextView.text else { return nil }
        var projectName = ""
        if projectNameLabel.text != nil {projectName = projectNameLabel.text!} else { projectName = "" } //projectNameLabel.text != "Project", condition need to be added
        let uid = AuthService.instance.getUID()
        task = Task(id: uid, title: title, assigneeName: assigneeName, projectName: projectName, dueDate: dutDate, description: description, members: [], tag: "", color: .white, status: .pending)
        return task
    }
    
    func prepareTaskForEditing() {
        self.assigneeNameLabel.text = task?.assigneeName
        self.projectNameLabel.text = task?.projectName
        self.titleTF.text = task?.title
        self.descriptionTextView.text = task?.description
        self.anyTimeButton.setTitle(task?.dueDate, for: .normal)
        self.projectNameLabel.text = task?.projectName
    }
    
    
}
//MARK: - Table view Datasource Delegate
extension CreateTaskVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DataService.instance.people.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: SelectionTVCell.className) as! SelectionTVCell
        cell.configure(assginee: DataService.instance.people[indexPath.row])
        return cell
    }
    
    
}
//MARK: -Table View Delegate
extension CreateTaskVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let name = DataService.instance.people[indexPath.row].name
        let image = DataService.instance.people[indexPath.row].avator
        setupAssignee(name: name, image: image)
        selectionTVHeightConstraint.constant = 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 52
    }
    
}
//MARK: - Collection View Datasource Delegate
extension CreateTaskVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if taskNature == .editingTask && !((task?.members.isEmpty)!) {
            return (task?.members.count)!
        }
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MemberCVC.className, for: indexPath) as! MemberCVC
        
        if taskNature == .editingTask && !((task?.members.isEmpty)!)  { //
            if indexPath.row != task?.members.count {
                //                cell.avator.image = task?.members[indexPath.row]
                cell.anyoneLabel.isHidden = true
                return cell
            } else {
                cell.anyoneLabel.text = "+"
                cell.anyoneLabel.textColor = .white
                return cell
            }
        } else {
            return cell
        }
        
    }
}
//MARK: - Collection View Flow Layout Delegate

extension CreateTaskVC: UICollectionViewDelegateFlowLayout {
    internal func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if taskNature == .editingTask  && !((task?.members.isEmpty)!)   {
            return CGSize(width: (30), height: 30);
        } else {
            return CGSize(width: (60), height: 30);
        }
    }
}
//MARK: -  Date picker delegate
extension CreateTaskVC: DatePickerViewDelegate {
    func didDateSelectionCompleted(date: String) {
        self.datePickerView.isHidden = true
        self.anyTimeButton.setTitle(date, for: .normal)
    }
    
    
}
