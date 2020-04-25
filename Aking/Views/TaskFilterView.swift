//
//  TaskFilterVu.swift
//  Aking
//
//  Created by Usama Sadiq on 4/14/20.
//  Copyright © 2020 Usama Sadiq. All rights reserved.
//

import UIKit

protocol TaskFilterViewDelegate {
    func incompleteTasksButtonDidTapped()
    func completedTaskButtonDidTapped()
    func allTasksButtonDidTapped()
}
class TaskFilterView: UIView {
    let NIB_NAME = "TaskFilterView"
    
    @IBOutlet weak var topButton: UIButton!
    @IBOutlet weak var centerButton: UIButton!
    @IBOutlet weak var bottomButton: UIButton!
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var incompleteTaskImageView: UIImageView!
    @IBOutlet weak var completedTaskImageView: UIImageView!
    @IBOutlet weak var allTaskImageView: UIImageView!
    enum selectedFilter {  case incomplete, completed, allTask }
    var selectedOption: selectedFilter = .incomplete
    
    var delegate: TaskFilterViewDelegate!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func commonInit() {
        Bundle.main.loadNibNamed(NIB_NAME, owner: self, options: nil)
        contentView.fixInView(self)
    }
    
    
    @IBAction func incompleteTaskButtonTapped(_ sender: UIButton) {
        selectedOption = .incomplete
        updateFilterView()
        delegate.incompleteTasksButtonDidTapped()
    }
    @IBAction func completedTaskButtonTapped(_ sender: UIButton) {
        selectedOption = .completed
        updateFilterView()
        delegate.completedTaskButtonDidTapped()
    }
    @IBAction func allTasksButtonTapped(_ sender: UIButton) {
        selectedOption = .allTask
        updateFilterView()
        delegate.allTasksButtonDidTapped()
    }
    
    func updateFilterView(){
        incompleteTaskImageView.image = nil
        completedTaskImageView.image = nil
        allTaskImageView.image = nil
        
        switch selectedOption {
        case .incomplete:
            self.incompleteTaskImageView.image = #imageLiteral(resourceName: "Filter-Selection")
        case .completed:
            self.completedTaskImageView.image = #imageLiteral(resourceName: "Filter-Selection")
        case .allTask:
            self.allTaskImageView.image = #imageLiteral(resourceName: "Filter-Selection")
        }
    }
    
    
}
