//
//  AddVC.swift
//  Aking
//
//  Created by Usama Sadiq on 4/7/20.
//  Copyright © 2020 Usama Sadiq. All rights reserved.
//

import UIKit

@available(iOS 13.0, *)
class AddVC: UIViewController {
    
    let createMenu = AddView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        createMenu.delegate = self
        
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        
    }
}
//MARK: - ADD VIEW DELEGATE
@available(iOS 13.0, *)
extension AddVC: AddViewDelegate {
    func addTaskDidTapped() {
        print("Add task button tapped")
        performSegue(withIdentifier: "ToCreateTaskVC", sender: self)
        
    }
    
    func addQuickNoteDidTapped() {
        print("Add Quick Note button tapped")
    }
    
    func addCheckListDidTapped() {
        print("Add Check List button tapped")
    }
    
    
}
