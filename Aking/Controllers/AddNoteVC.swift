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
    
    @IBAction func addTaskButtonTapped(_ sender: Any) {
    }
    
    
    
}

extension AddNoteVC: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CVC_Color_Chooser", for: indexPath) as! AddNoteCollectionViewCell
        cell.colorView.backgroundColor = .random
        cell.colorView.layer.cornerRadius = 5
        return cell
    }
    
    
    
}

