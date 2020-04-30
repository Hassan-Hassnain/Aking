//
//  ProjecstVC.swift
//  Aking
//
//  Created by Usama Sadiq on 4/16/20.
//  Copyright © 2020 Usama Sadiq. All rights reserved.
//

import UIKit

class ProjecstVC: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var addProjectView: UIView!
    @IBOutlet weak var titleTF: UITextField!
    @IBOutlet weak var colorChooseCollectionView: UICollectionView!
    
    
    var projects: [Project] = []// {didSet{collectionView.reloadData()}}
    var isLoadedForProjectSelection: Bool = false
    var newProject: Project = Project(id: "", color: .white, projectName: "", numberOfTasks: 0, date: "")
    var task: Task?
    
    var colors: [UIColor] = [] {didSet{colorChooseCollectionView.reloadData()}}
//MARK: - Initializers & Deinitializers
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        colorChooseCollectionView.delegate = self
        colorChooseCollectionView.dataSource = self
        addProjectView.isHidden = true
        titleTF.delegate = self
        DataService.instance.getAllColors { (result) in
            self.colors = result
            print(self.colors)
        }
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        DataService.instance.getAllProject { (reslut) in
            if let result = reslut {
                self.projects = result
                self.sortProjectsArray()
                self.collectionView.reloadData()
            }
        }
        self.updateNavBarAppearance(color: #colorLiteral(red: 0.3972494602, green: 0.4466651082, blue: 1, alpha: 1), title: nil)
        navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        navigationController?.navigationBar.isHidden = false
    }

//MARK: - Helping Functions
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        newProject.projectName = titleTF.text!
        return titleTF.resignFirstResponder()
    }
    
    func addCheckMark(vu: UIView){
        let imageView = UIImageView(image: #imageLiteral(resourceName: "Icon-CheckMark"))
        imageView.tag = 100
        vu.addSubview(imageView)
        imageView.center = vu.center
        colorChooseCollectionView.reloadData()
    }
    
    fileprivate func createNewProject(_ cell: AddNoteCollectionViewCell, _ collectionView: UICollectionView) {
        if titleTF.text!.isEmpty{
            let place = "Please write the project title"
            titleTF.attributedPlaceholder = NSAttributedString(string: place, attributes:[NSAttributedString.Key.foregroundColor: UIColor.red])
            return
        }
        let place = "Please write the project title"
        titleTF.attributedPlaceholder = NSAttributedString(string: place, attributes:[NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        
        newProject.color = cell.colorView.backgroundColor!
        newProject.projectName = titleTF.text!
        
        DataService.instance.uploadProject(withProject: newProject) { (success) in
            print("Project uploading done")
            collectionView.reloadData()
        }
        self.addProjectView.isHidden = true
    }
    
    func showProjectDetails(indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: MyTaskVC.className) as! MyTaskVC
        vc.viewMode = .ProjectDetails
        vc.currentProjectName = projects[indexPath.row].projectName
        navigationController?.pushViewController(vc, animated: true)
    }
    
    fileprivate func showAddProjectView() {
        //show add project view to Create new project
        addProjectView.isHidden = false
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let dateCreated = dateFormatter.string(from: Date())
        
        newProject = Project(id: "", color: .clear, projectName: "", numberOfTasks: 0, date: dateCreated)
        titleTF.text = ""
    }
    
    fileprivate func updateProjectNumberOfTasks(_ project: Project, _ task: Task) {
        if project.projectName != task.projectName {
            let numberOfTask = project.numberOfTasks + 1
            let thisProject = Project(id: project.id, color: project.color, projectName: project.projectName, numberOfTasks: numberOfTask, date: project.date)
            DataService.instance.updateProject(withProject: thisProject) { (success) in
                print("Project Updated")
            }
        }
        
        for proj in projects {
            if task.projectName == proj.projectName {
                let p = Project(id: proj.id, color: proj.color, projectName: proj.projectName, numberOfTasks: proj.numberOfTasks - 1, date: proj.date)
                DataService.instance.updateProject(withProject: p) { (success) in
                    print("number of task decresed in \(proj.projectName)")
                }
            }
        }
    }
    
    fileprivate func selectProjectForTask(project: Project) {
        if var task = self.task {
            updateProjectNumberOfTasks(project, task)
            task.projectName = project.projectName
            DataService.instance.updateTask(withTask: task) { (success) in
                if success {
                    self.navigationController?.popViewController(animated: true)
                    return
                }
            }
        }
    }
    
    func sortProjectsArray(){
        projects = projects.sorted(by: {$0.date.compare($1.date) == .orderedAscending})
    }
    
    
}

//MARK: - Collection DELEGATE AN DATASOURCE
extension ProjecstVC: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == colorChooseCollectionView {
            return colors.count
        }
        if isLoadedForProjectSelection {
            return self.projects.count
        }
        return self.projects.count+1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == colorChooseCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AddNoteCollectionViewCell.className, for: indexPath) as! AddNoteCollectionViewCell
            //            cell.configure(color: colors[indexPath.row])
            cell.colorView.backgroundColor = colors[indexPath.row]
            return cell
        }
        let projectCell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProjectCell", for: indexPath) as! ProjectCollectionViewCell
        let addCell = collectionView.dequeueReusableCell(withReuseIdentifier: "AddProjectCell", for: indexPath)
        if indexPath.row == self.projects.count {
            return addCell
        }
        projectCell.configure(project: projects[indexPath.row])
        return projectCell
    }
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == self.collectionView {
            if isLoadedForProjectSelection {
                return selectProjectForTask(project: projects[indexPath.row])
            }
            if indexPath.row == projects.count {
                showAddProjectView()
            } else {
                showProjectDetails(indexPath: indexPath)
            }
        }
        
        if collectionView == colorChooseCollectionView {
            let cell = collectionView.cellForItem(at: indexPath) as! AddNoteCollectionViewCell
            createNewProject(cell, collectionView)
        }
    }
    
    
}


