//
//  ViewTaskVC.swift
//  Aking
//
//  Created by Usama Sadiq on 4/16/20.
//  Copyright © 2020 Usama Sadiq. All rights reserved.
//

import UIKit

class ViewTaskVC: UIViewController {

    @IBOutlet weak var additionalDetailView: UIView!
    @IBOutlet weak var additionalDetailViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var commentButton: UIStackView!
    
    @IBOutlet weak var commentsTableView: UITableView!
    
    var settingView: UIView?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        hideAdditionDetails()
        createSettingView()
        commentsTableView.dataSource = self
        commentsTableView.delegate = self
    }
    
    @IBAction func closeButton(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func commentButtonTapped(_ sender: Any) {
        showAdditionalDetails()
        commentButton.isHidden = true
    }
    @IBAction func completeTaskButtonTapped(_ sender: Any) {
        commentButton.isHidden = false
        hideAdditionDetails()
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
        let trailingConstant: CGFloat = 31
        let width: CGFloat = 228.0
        let height: CGFloat = 130.0
        let x: CGFloat = self.view.frame.size.width - (width + trailingConstant)
        let y: CGFloat = 114.0
        let optionsView = TaskFilterView(frame: CGRect(x: x, y: y, width: width, height: height))
        optionsView.allTaskImageView.isHidden = true
        optionsView.completedTaskImageView.isHidden = true
        optionsView.incompleteTaskImageView.isHidden = true
        optionsView.topButton.setTitle("Add to Project", for: .normal)
        optionsView.centerButton.setTitle("Add Member", for: .normal)
        optionsView.bottomButton.setTitle("Delete Task", for: .normal)
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
