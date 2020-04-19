//
//  DatePickerView.swift
//  Aking
//
//  Created by Usama Sadiq on 4/15/20.
//  Copyright © 2020 Usama Sadiq. All rights reserved.
//

import UIKit
import FSCalendar

protocol DatePickerViewDelegate {
    func didDateSelectionCompleted(date: String) -> Void
}
class DatePickerView: UIView {

    let XIB_NAME = "DatePickerView"
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var calendar: FSCalendar!
    
    var delegate: DatePickerViewDelegate?
    var selectedDate: String?
    
    fileprivate let formatter: DateFormatter = {
        let formatter = DateFormatter()
//        formatter.dateFormat = "yyyy/MM/dd"
        formatter.dateFormat = "dd/MM/yyyy"
        return formatter
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    func commonInit() {
        Bundle.main.loadNibNamed(XIB_NAME, owner: self, options: nil)
        containerView.fixInView(self)
        calendar.delegate = self
    }
    @IBAction func doneButtonTapped(_ sender: Any) {
        if let date = selectedDate {
            delegate?.didDateSelectionCompleted(date: date)
        }
    }
    
    
}

extension DatePickerView: FSCalendarDelegate {
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        selectedDate = date.getFormattedDate()
        if monthPosition == .previous || monthPosition == .next {
            calendar.setCurrentPage(date, animated: true)
        }
    }
}
