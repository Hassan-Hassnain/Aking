//
//  ProjecstVC.swift
//  Aking
//
//  Created by Usama Sadiq on 4/16/20.
//  Copyright © 2020 Usama Sadiq. All rights reserved.
//

import UIKit

class ProjecstVC: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.delegate = self
        collectionView.dataSource = self
    }
    

   

}

extension ProjecstVC: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        projects.count+1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let projectCell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProjectCell", for: indexPath) as! ProjectCollectionViewCell
        let addCell = collectionView.dequeueReusableCell(withReuseIdentifier: "AddProjectCell", for: indexPath)
        if indexPath.row == projects.count {
            return addCell
        }
        projectCell.configure(project: projects[indexPath.row])
        return projectCell
    }
    
    
}
