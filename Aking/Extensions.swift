//
//  Date++.swift
//  Aking
//
//  Created by Usama Sadiq on 4/7/20.
//  Copyright © 2020 Usama Sadiq. All rights reserved.
//

import UIKit



extension Date {
    static func getFormattedDate(date: Date) -> String {
        let dateformat = DateFormatter()
        dateformat.dateFormat = "MMM d/yyyy"
        return dateformat.string(from: date)
    }
}


extension UIView {
    func addShadow(){
       layer.shadowColor = UIColor.black.cgColor
       layer.shadowOffset = CGSize(width: 0, height: 3)
       layer.shadowOpacity = 0.1
       layer.shadowRadius = 4.0
    }
}
