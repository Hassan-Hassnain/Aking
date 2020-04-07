//
//  MyTaskVC.swift
//  Aking
//
//  Created by Usama Sadiq on 4/6/20.
//  Copyright © 2020 Usama Sadiq. All rights reserved.
//

import UIKit
import FSCalendar

class MyTaskVC: UIViewController {
    //MARK: - CALANDER AND MONTH PROPERITES AND FUNCTIONS
    
    @IBOutlet weak var todayButton: UIButton!
    @IBOutlet weak var monthButton: UIButton!
    @IBOutlet weak var calanderView: FSCalendar!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var calanderViewHeightConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
//        showAddView()
    }
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        //        if tabBarController?.viewControllers![2].tabBarItem.tag == 2 {
//        if tabBarController?.selectedIndex == 2 {
////        if shouldShowAddView {
//            addView?.isHidden = false
//        } else {
//            addView?.isHidden = true
//        }
//    }

    @IBAction func toggleCalanderButtonTapped(_ sender: Any) {
        if calanderView.scope == .week {
            calanderView.scope = .month
            
            calanderViewHeightConstraint.constant  = 327
            
        } else {
            calanderView.scope = .week
            calanderViewHeightConstraint.constant  = 130
        }
        
    }
    @IBAction func todayButtonTapped(_ sender: Any) {
        calanderViewHeightConstraint.constant  = 0
        monthButton.setTitleColor(.gray, for: .normal)
    }
    @IBAction func monthButtonTapped(_ sender: Any) {
        calanderView.scope = .week
        calanderViewHeightConstraint.constant  = 130
        todayButton.setTitleColor(.gray, for: .normal)
    }
    @IBAction func filterButtonTapped(_ sender: UIButton) {
        if filterView.isHidden {
            filterView.isHidden = false
        } else {
            filterView.isHidden = true
        }
    }
    
    //MARK: - FILTER VIEW
    
    @IBOutlet weak var filterView: UIView!
    @IBOutlet weak var incompleteTaskImageView: UIImageView!
    @IBOutlet weak var completedTaskImageView: UIImageView!
    @IBOutlet weak var allTaskImageView: UIImageView!
    enum selectedFilter {  case incomplete, completed, allTask }
    var selectedOption: selectedFilter = .incomplete
    
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
    //MARK: - ADD NEW
//    func showAddView() {
//        addView = AddView()
//        view.addSubview(addView!)
//        addView!.fixInView(self.view)
//        addView!.delegate = self
//    }
    //MARK: - COMMON FUNCTIONS
    fileprivate func setupUI() {
        if filterView != nil{filterView.isHidden = true}
        if monthButton != nil{monthButton.setTitleColor(.gray, for: .normal)}
        //           print(Date.getFormattedDate(date: calanderView.today!))
    }
}
//MARK: - TABLE VIEW DELEGATE AN DATASOURCE
extension MyTaskVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?{
        let vu = UIView()
        vu.backgroundColor = .clear
        let label = UILabel(frame: CGRect(x: 16, y: 8, width: tableView.frame.size.width, height: 15))
        label.text = "Today, \(String(describing: Date.getFormattedDate(date: calanderView.today!)))"
        label.textColor = .black
        vu.addSubview(label)
        return vu
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Today, \(String(describing: Date.getFormattedDate(date: Date())))"
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TaskCell")!
        //        cell.contentView.dropShadow(color: .black, opacity: 0.3, offSet: CGSize(width: -0.2, height: 0.3), radius: 3, scale: true)
        cell.contentView.addShadow()
        return cell
    }
    
    
}

