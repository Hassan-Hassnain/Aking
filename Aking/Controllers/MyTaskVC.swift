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
    
    @IBOutlet weak var todayButton: UIButton!
    @IBOutlet weak var monthButton: UIButton!
    @IBOutlet weak var calanderView: FSCalendar!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var calanderViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var calendarToggleButton: UIButton!
    
    var filterView = TaskFilterView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        updateNavBarAppearance()
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
        monthButton.setTitleColor(.gray, for: .normal)
        calendarToggleButton.isHidden = true
    }
    @IBAction func monthButtonTapped(_ sender: Any) {
        calanderView.scope = .week
        calanderViewHeightConstraint.constant  = 130
        todayButton.setTitleColor(.gray, for: .normal)
        monthButton.setTitleColor(.white, for: .normal)
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
        view.addSubview(filterView)
        filterView.isHidden = true
        if monthButton != nil{monthButton.setTitleColor(.gray, for: .normal)}
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


