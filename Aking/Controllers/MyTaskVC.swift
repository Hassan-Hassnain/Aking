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
    @IBOutlet weak var todayButtonBottomIndicator: UIView!
    @IBOutlet weak var monthButtonBottomIndicator: UIView!
    
    var filterView = TaskFilterView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        updateNavBarAppearance(color: #colorLiteral(red: 0.9624031186, green: 0.3883901834, blue: 0.3891221285, alpha: 1))
        tableView.regCell(cellName: WorkListTableViewCell.className)
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupTodayView()
        navigationController?.hideHairline()
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
        setupTodayView()
    }
    
    @IBAction func monthButtonTapped(_ sender: Any) {
        setupMonthView()
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
        monthButtonBottomIndicator.isHidden = true
        
        NotificationCenter.default.addObserver(self, selector: #selector(addTaskDidTapped), name: NSNotification.Name(rawValue: KNotifcations.NEW_TASK), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(addQuickNoteDidTapped), name: NSNotification.Name(rawValue: KNotifcations.QUICK_NOTE), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(addCheckListDidTapped), name: NSNotification.Name(rawValue: KNotifcations.CHECK_LIST), object: nil)
    }
    
    fileprivate func setupTodayView() {
        calanderViewHeightConstraint.constant  = 0
        todayButton.setTitleColor(.white, for: .normal)
        todayButtonBottomIndicator.isHidden = false
        monthButton.setTitleColor(.gray, for: .normal)
        monthButtonBottomIndicator.isHidden = true
        calendarToggleButton.isHidden = true
    }
    
    fileprivate func setupMonthView() {
        calanderView.scope = .week
        calanderViewHeightConstraint.constant  = 130
        todayButton.setTitleColor(.gray, for: .normal)
        todayButtonBottomIndicator.isHidden = true
        monthButton.setTitleColor(.white, for: .normal)
        monthButtonBottomIndicator.isHidden = false
        calendarToggleButton.isHidden = false
    }
    //MARK: - DATE FUNCTIONS
    func isToday(date: String)-> Bool{
        let taskDate = convertStringToDate(date: date)
        // Get right now as it's `DateComponents`.
        let now = Calendar.current.dateComponents(in: .current, from: Date())
        
        // Create the start of the day in `DateComponents` by leaving off the time.
        let today = DateComponents(year: now.year, month: now.month, day: now.day)
        let dateToday = Calendar.current.date(from: today)!
        print(dateToday.timeIntervalSince1970)
        return taskDate == dateToday
        
        
    }
    
    func today() -> String{
        let now = Calendar.current.dateComponents(in: .current, from: Date())
        let today = DateComponents(year: now.year, month: now.month, day: now.day)
        let dateToday = Calendar.current.date(from: today)!
        return Date.getFormattedDate(date: dateToday)
    }
    
    func tomorrow() -> String {
        let now = Calendar.current.dateComponents(in: .current, from: Date())
        let tomorrow = DateComponents(year: now.year, month: now.month, day: now.day! + 1)
        let dateTomorrow = Calendar.current.date(from: tomorrow)!
        return Date.getFormattedDate(date: dateTomorrow)
    }
    
    
    func convertStringToDate(date: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let date = dateFormatter.date(from:date)!
        return date
    }
    
}
//MARK: - TABLE VIEW DELEGATE AN DATASOURCE
extension MyTaskVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?{
        if section == 0 {
            return setupHeaderView(withDate: today())
        } else {
            return setupHeaderView(withDate: tomorrow())
        }
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Today, \(String(describing: Date.getFormattedDate(date: Date())))"
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        DataService.instance.tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: WorkListTableViewCell.className) as! WorkListTableViewCell
        cell.configure(task: DataService.instance.tasks[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let vc = storyboard?.instantiateViewController(identifier: ViewTaskVC.className) as! ViewTaskVC
        var task = DataService.instance.tasks[indexPath.row]
        task.id = indexPath.row
        vc.currentTask = task
        navigationController?.pushViewController(vc, animated: true)
    }
    //MARK: - Swipe Cell Action
    
    func tableView(_ tableView: UITableView,
                   trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration?
    {
        let deleteAction = UIContextualAction(style: .normal, title:  "Close", handler: { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
            DataService.instance.tasks.remove(at:indexPath.row)
            tableView.reloadData()
            print("Task deleted")
            success(true)
        })
        deleteAction.image = UIImage(named: "Icon-Delete")
        deleteAction.backgroundColor = .white
        
        
        
        let editAction = UIContextualAction(style: .normal, title:  "Update", handler: { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
            success(true)
            let vc = self.storyboard?.instantiateViewController(identifier: CreateTaskVC.className) as! CreateTaskVC
            vc.initTask(task: DataService.instance.tasks[indexPath.row])
            print("Editing Task")
            self.navigationController?.pushViewController(vc, animated: true)
        })
        editAction.image = UIImage(named: "Icon-Edit")
        editAction.backgroundColor = .white
        
        return UISwipeActionsConfiguration(actions: [deleteAction, editAction])
        
    }
    
    func setupHeaderView(withDate date: String) -> UIView{
        let vu = UIView()
        vu.backgroundColor = .clear
        let label = UILabel(frame: CGRect(x: 16, y: 8, width: tableView.frame.size.width, height: 15))
        label.text = date
        label.textColor = .black
        vu.addSubview(label)
        
        return vu
    }
}

//MARK: - Create Menu functions
extension MyTaskVC {
    @objc func addTaskDidTapped() {
        filterView.isHidden = true
        pushVC(viewController: CreateTaskVC.className, animated: true)
    }
    
    @objc func addQuickNoteDidTapped() {
        filterView.isHidden = true
        pushVC(viewController: AddNoteVC.className, animated: true)
    }
    
    @objc func addCheckListDidTapped() {
        filterView.isHidden = true
        pushVC(viewController: AddCheckListVC.className, animated: true)
    }
    
    
}
