//
//  ProfileVC.swift
//  Aking
//
//  Created by Usama Sadiq on 4/6/20.
//  Copyright © 2020 Usama Sadiq. All rights reserved.
//

import UIKit
import ATCircularProgressView

class ProfileVC: UIViewController {

    @IBOutlet weak var profileImage: CustomizableImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var numberOfCreateTask: UILabel!
    @IBOutlet weak var numberOfCompletedTask: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var eventProgressView: CircularProgressView!
    @IBOutlet weak var eventProgressLabel: UILabel!
    @IBOutlet weak var todoProgressView: CircularProgressView!
    @IBOutlet weak var todoProgressLabel: UILabel!
    @IBOutlet weak var quickNotesProgressView: CircularProgressView!
    @IBOutlet weak var quickNoteProgressLable: UILabel!
    

    
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.dataSource  = self
        collectionView.delegate = self
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
         let progressChanged: (CircularProgressView, CGFloat) -> () = { [unowned self]
              (progressView, progress) in
              let value = Int(progress * 100.0)
              self.eventProgressLabel.text = "\(value)%"
        }
                
        eventProgressView.progressChanged = progressChanged
        
        
        
        eventProgressLabel.text = "\(Int((eventProgressView.progress)*100))"
        todoProgressLabel.text = "\(Int((todoProgressView.progress)*100))"
        quickNoteProgressLable.text = "\(Int((quickNotesProgressView.progress)*100))"
    }


}

extension ProfileVC: UICollectionViewDataSource, UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
        cell.layer.cornerRadius = 5
        return cell
    }
    
    
}
