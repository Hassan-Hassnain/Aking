//
//  ProjectDetailsVC.swift
//  Aking
//
//  Created by Usama Sadiq on 4/17/20.
//  Copyright © 2020 Usama Sadiq. All rights reserved.
//


import UIKit
import FSCalendar

class ProjectDetailsVC: UIViewController {
    
    @IBOutlet weak var todayButton: UIButton!
    @IBOutlet weak var monthButton: UIButton!
    @IBOutlet weak var calanderView: FSCalendar!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var calanderViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var calendarToggleButton: UIButton!
    @IBOutlet weak var todayButtonBottomIndicator: UIView!
    @IBOutlet weak var monthButtonBottomIndicator: UIView!
    
    var filterView = TaskFilterView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        updateNavBarAppearance(color: #colorLiteral(red: 0.3764705882, green: 0.4549019608, blue: 0.9764705882, alpha: 1), title: "Projects")
        
        tableView.regCell(cellName: WorkListTableViewCell.className)
        
        NotificationCenter.default.addObserver(self, selector: #selector(addTaskDidTapped), name: NSNotification.Name(rawValue: KNotifcations.NEW_TASK), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(addQuickNoteDidTapped), name: NSNotification.Name(rawValue: KNotifcations.QUICK_NOTE), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(addCheckListDidTapped), name: NSNotification.Name(rawValue: KNotifcations.CHECK_LIST), object: nil)
        
    }
    
    @IBAction func toggleCalanderButtonTapped(_ sender: Any) {
        if calanderView.scope == .week {
            calanderView.scope = .month
            UIView.animate(withDuration: 0.2) {
                self.calendarToggleButton.transform = CGAffineTransform(rotationAngle: CGFloat(-Double.pi * 180)/180)
                self.calanderViewHeightConstraint.constant = 327
                self.loadViewIfNeeded()
            }
        } else {
            calanderView.scope = .week
            UIView.animate(withDuration: 0.2) {
                self.calendarToggleButton.transform = CGAffineTransform(rotationAngle: 0)
                self.calanderViewHeightConstraint.constant  = 130
                self.loadViewIfNeeded()
            }
        }
        
    }
    @IBAction func todayButtonTapped(_ sender: Any) {
        calanderViewHeightConstraint.constant  = 0
        todayButton.setTitleColor(.white, for: .normal)
        todayButtonBottomIndicator.isHidden = false
        monthButton.setTitleColor(.gray, for: .normal)
        monthButtonBottomIndicator.isHidden = true
        calendarToggleButton.isHidden = true
    }
    @IBAction func monthButtonTapped(_ sender: Any) {
        calanderView.scope = .week
        calanderViewHeightConstraint.constant  = 130
        todayButton.setTitleColor(.gray, for: .normal)
        todayButtonBottomIndicator.isHidden = true
        monthButton.setTitleColor(.white, for: .normal)
        monthButtonBottomIndicator.isHidden = false
        calendarToggleButton.isHidden = false
    }
    
    @IBAction func filterButtonTapped(_ sender: UIBarButtonItem) {
        if filterView.isHidden {
            filterView.isHidden = false
        } else {
            filterView.isHidden = true
        }
    }
    
    fileprivate func setupUI() {
        filterView = TaskFilterView(frame: CGRect(x: 172, y: 89, width: 228, height: 130))
        filterView.delegate = self
        view.addSubview(filterView)
        filterView.isHidden = true
        if monthButton != nil{monthButton.setTitleColor(.gray, for: .normal)}
        monthButtonBottomIndicator.isHidden = true
    }
}
//MARK: - TABLE VIEW DELEGATE AN DATASOURCE
extension ProjectDetailsVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?{
        let vu = UIView()
        vu.backgroundColor = .clear
        let label = UILabel(frame: CGRect(x: 16, y: 8, width: tableView.frame.size.width, height: 15))
        label.text = "Today, \(calanderView.today!.getFormattedDate())"
        label.textColor = .black
        vu.addSubview(label)
        return vu
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Today, \(String(describing: Date().getFormattedDate()))"
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: WorkListTableViewCell.className) as! WorkListTableViewCell
        cell.colorView.backgroundColor = .random
        cell.contentView.addShadow()
        return cell
    }
    
    
}

//MARK: - Create Menu functions
extension ProjectDetailsVC {
    @objc func addTaskDidTapped() {
        guard let vc = storyboard?.instantiateViewController(withIdentifier: CreateTaskVC.className) else {return}
        filterView.isHidden = true
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func addQuickNoteDidTapped() {
        print("Add Quick Note button tapped")
    }
    
    @objc func addCheckListDidTapped() {
        print("Add Check List button tapped")
    }
    
    
}

//MARK: - FilterView delegate
extension ProjectDetailsVC: TaskFilterViewDelegate{
    func incompleteTasksButtonDidTapped() {
        filterView.isHidden = true
        print("incomplete TAsk")
        
    }
    
    func completedTaskButtonDidTapped() {
        print("Completed Task")
    }
    
    func allTasksButtonDidTapped() {
        print("All Task")
    }
    
    
}
