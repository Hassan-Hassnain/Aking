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
    var todayTasks: [Task] = []
    var tomorrowTasks: [Task] = []
    var myTasks: [[Task]] = []
    enum FilterMode { case completed, incomplete, all}
    var taskLoadingMode: FilterMode = .all
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        updateNavBarAppearance(color: #colorLiteral(red: 0.9624031186, green: 0.3883901834, blue: 0.3891221285, alpha: 1))
        tableView.regCell(cellName: WorkListTableViewCell.className)
        calanderView.delegate = self
        calanderView.dataSource = self
        filterView.delegate = self
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateTodayAndTomorrowTasks {
            self.tableView.reloadData()
        }
        myTasks = [todayTasks, tomorrowTasks]
        tableView.reloadData()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupTodayView()
        //        navigationController?.hideHairline()
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
    
    fileprivate func today() -> Date{
        let now = Calendar.current.dateComponents(in: .current, from: Date())
        let today = DateComponents(year: now.year, month: now.month, day: now.day)
        let dateToday = Calendar.current.date(from: today)!
        return dateToday
    }
    
    fileprivate func tomorrow() -> Date {
        let now = Calendar.current.dateComponents(in: .current, from: Date())
        let tomorrow = DateComponents(year: now.year, month: now.month, day: now.day! + 1)
        let dateTomorrow = Calendar.current.date(from: tomorrow)!
        return dateTomorrow
    }
    
    fileprivate func updateTodayAndTomorrowTasks(complete: @escaping ()->()){
        tomorrowTasks = []
        todayTasks = []
        switch taskLoadingMode {
        case .completed:
            for thisTask in DataService.instance.tasks {
                let date = thisTask.dueDate.getFormattedDate()
                if compareDates(firstDate: today(), secondDate: date) == 0 {
                    if thisTask.status == .done {self.todayTasks.append(thisTask)}
                } else if compareDates(firstDate: tomorrow(), secondDate: date) == 0 {
                    if thisTask.status == .done {tomorrowTasks.append(thisTask)}
                }
            }
            print("Arrays populated with incomplete task")
        case .incomplete:
            for thisTask in DataService.instance.tasks {
                let date = thisTask.dueDate.getFormattedDate()
                if compareDates(firstDate: today(), secondDate: date) == 0 {
                    if thisTask.status == .pending {self.todayTasks.append(thisTask)}
                } else if compareDates(firstDate: tomorrow(), secondDate: date) == 0 {
                    if thisTask.status == .pending {tomorrowTasks.append(thisTask)}
                }
            }
            print("Arrays populated with complete task")
        case .all:
            for thisTask in DataService.instance.tasks {
                let date = thisTask.dueDate.getFormattedDate()
                if compareDates(firstDate: today(), secondDate: date) == 0 {
                    self.todayTasks.append(thisTask)
                } else if compareDates(firstDate: tomorrow(), secondDate: date) == 0 {
                    tomorrowTasks.append(thisTask)
                }
            }
            print("Arrays populated with all task")
        }
    }
    
    fileprivate func compareDates( firstDate: Date, secondDate: Date) -> Int {
        if firstDate.compare(secondDate) == .orderedSame { return 0 }
        else if firstDate.compare(secondDate) == .orderedAscending { return -1 }
        else { return 1  }
    }
    
    
}
//MARK: - TABLE VIEW DELEGATE AN DATASOURCE
extension MyTaskVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return myTasks.count
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?{
        if section == 0 {
            return setupHeaderView(withDate: "TODAY, "  + today().getFormattedDate())
        } else {
            return setupHeaderView(withDate: "TOMORROW, " + tomorrow().getFormattedDate())
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        myTasks[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: WorkListTableViewCell.className) as! WorkListTableViewCell
        cell.configure(task: myTasks[indexPath.section][indexPath.row])
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
            success(true)
        })
        deleteAction.image = UIImage(named: "Icon-Delete")
        deleteAction.backgroundColor = .white
        
        let editAction = UIContextualAction(style: .normal, title:  "Update", handler: { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
            success(true)
            let vc = self.storyboard?.instantiateViewController(identifier: CreateTaskVC.className) as! CreateTaskVC
            var taskToEdit = DataService.instance.tasks[indexPath.row]
            taskToEdit.id = indexPath.row
            vc.initTask(task: taskToEdit)
            self.navigationController?.pushViewController(vc, animated: true)
        })
        editAction.image = UIImage(named: "Icon-Edit")
        editAction.backgroundColor = .white
        
        return UISwipeActionsConfiguration(actions: [deleteAction, editAction])
        
    }
    
    fileprivate func setupHeaderView(withDate date: String) -> UIView{
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
//MARK: - FS Calendar delegate and Datasource
extension MyTaskVC : FSCalendarDelegate, FSCalendarDataSource {
    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
        
        for task in DataService.instance.tasks{
            if(compareDates(firstDate: date, secondDate: task.dueDate.getFormattedDate()) == 0)
            {
                return 1
            }
        }
        return 0
    }
}
//MARK: - FilterView delegate
extension MyTaskVC: TaskFilterViewDelegate{
    func incompleteTasksButtonDidTapped() {
        taskLoadingMode = .incomplete
        updateTodayAndTomorrowTasks {
            self.tableView.reloadData()
        }
        filterView.isHidden = true
    }
    
    func completedTaskButtonDidTapped() {
        taskLoadingMode = .completed
        updateTodayAndTomorrowTasks {
            self.tableView.reloadData()
        }
        filterView.isHidden = true
    }
    
    func allTasksButtonDidTapped() {
        taskLoadingMode = .all
        updateTodayAndTomorrowTasks {
            self.tableView.reloadData()
        }
        filterView.isHidden = true
    }
    
    
}
