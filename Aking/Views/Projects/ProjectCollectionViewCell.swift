//
//  ProjectCollectionViewCell.swift
//  Aking
//
//  Created by Usama Sadiq on 4/16/20.
//  Copyright © 2020 Usama Sadiq. All rights reserved.
//

import UIKit

class ProjectCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var ourterView: CustomizableView!
    @IBOutlet weak var innerView: CustomizableView!
    @IBOutlet weak var projectName: UILabel!
    @IBOutlet weak var numberOfProject: UILabel!
    
    func configure(project: Project){
        ourterView.backgroundColor = project.color
        ourterView.backgroundColor = project.color.withAlphaComponent(0.25)
        ourterView.isOpaque = false
        innerView.backgroundColor = project.color
        projectName.text = project.projectName
        numberOfProject.text = project.numberOfTasks
    }
}

