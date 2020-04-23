//
//  AddNoteVC.swift
//  Aking
//
//  Created by Usama Sadiq on 4/16/20.
//  Copyright © 2020 Usama Sadiq. All rights reserved.
//

import UIKit

class AddNoteVC: UIViewController {
    
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    @IBAction func backButtonTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func addTaskButtonTapped(_ sender: Any) {
    }
    
    
    
}

extension AddNoteVC: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        DataService.instance.colors.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AddNoteCollectionViewCell.className, for: indexPath) as! AddNoteCollectionViewCell
        cell.colorView.backgroundColor = DataService.instance.colors[indexPath.row]
        cell.colorView.layer.cornerRadius = 5
        return cell
    }
    
    
    
}

