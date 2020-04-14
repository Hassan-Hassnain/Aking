//
//  FilterView.swift
//  Aking
//
//  Created by Usama Sadiq on 4/14/20.
//  Copyright © 2020 Usama Sadiq. All rights reserved.
//

import UIKit

class TaskFilterView: UIView {
    let FILTER_VIEW_XIB_NAME = "FilterView"
  @IBOutlet var filterView: UIView!
  @IBOutlet weak var incompleteTaskImageView: UIImageView!
  @IBOutlet weak var completedTaskImageView: UIImageView!
  @IBOutlet weak var allTaskImageView: UIImageView!
  enum selectedFilter {  case incomplete, completed, allTask }
  var selectedOption: selectedFilter = .incomplete
  
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        commonInit()
//    }
//    
//    required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//        commonInit()
//    }
//    
//    func commonInit() {
//        Bundle.main.loadNibNamed(FILTER_VIEW_XIB_NAME, owner: self, options: nil)
//        filterView = FilterView(frame: CGRect(x: 172, y: 89, width: 228, height: 130))
//    }
    
  @IBAction func incompleteTaskButtonTapped(_ sender: UIButton) {
      selectedOption = .incomplete
      updateFilterView()
  }
  @IBAction func completedTaskButtonTapped(_ sender: UIButton) {
      selectedOption = .completed
      updateFilterView()
  }
  @IBAction func allTasksButtonTapped(_ sender: UIButton) {
      selectedOption = .allTask
      updateFilterView()
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
