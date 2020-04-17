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
    
    var project = Project(color: .clear, projectName: "", numberOfTasks: "0")
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        colorChooseCollectionView.delegate = self
        colorChooseCollectionView.dataSource = self
        addProjectView.isHidden = true
        titleTF.delegate = self
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        project.projectName = titleTF.text!
        addNewProject()
        return titleTF.resignFirstResponder()
    }
   
    func addNewProject(){
        if project.color == UIColor.clear, project.projectName == "" {
            return
        } else {
            projects.append(project)
            collectionView.reloadData()
        }
    }
    
    func addCheckMark(vu: UIView){
        let imageView = UIImageView(image: #imageLiteral(resourceName: "Icon-CheckMark"))
        imageView.tag = 100
        vu.addSubview(imageView)
        imageView.center = vu.center
        colorChooseCollectionView.reloadData()
    }
    
}

extension ProjecstVC: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == colorChooseCollectionView {
            return colors.count
        }
        return projects.count+1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == colorChooseCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CVC_Color_Chooser", for: indexPath) as! AddNoteCollectionViewCell
            cell.colorView.backgroundColor = colors[indexPath.row]
            cell.colorView.layer.cornerRadius = 5
            for subview in cell.contentView.subviews {
                if (subview.tag == 100) {
                    subview.removeFromSuperview()
                }
            }
            return cell
        }
        let projectCell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProjectCell", for: indexPath) as! ProjectCollectionViewCell
        let addCell = collectionView.dequeueReusableCell(withReuseIdentifier: "AddProjectCell", for: indexPath)
        if indexPath.row == projects.count {
            return addCell
        }
        projectCell.configure(project: projects[indexPath.row])
        return projectCell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if collectionView == colorChooseCollectionView {
            
            let cell = collectionView.cellForItem(at: indexPath) as! AddNoteCollectionViewCell
            if titleTF.text!.isEmpty{
                let place = "Please write the project title"
                titleTF.attributedPlaceholder = NSAttributedString(string: place, attributes:[NSAttributedString.Key.foregroundColor: UIColor.red])
//                addCheckMark(vu: cell.colorView)
                return
            }
            
            project.color = cell.colorView.backgroundColor!
            addNewProject()
            self.addProjectView.isHidden = true
        }
        if indexPath.row == projects.count {
            addProjectView.isHidden = false
            project = Project(color: .clear, projectName: "", numberOfTasks: "0")
            titleTF.text = ""
               }
    }
    
    
}


