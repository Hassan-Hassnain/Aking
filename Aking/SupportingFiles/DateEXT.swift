//
//  DateEXT.swift
//  Aking
//
//  Created by Usama Sadiq on 4/15/20.
//  Copyright © 2020 Usama Sadiq. All rights reserved.
//

import Foundation

extension Date {
    static func getFormattedDate(date: Date) -> String {
        let dateformat = DateFormatter()
        dateformat.dateFormat = "MMM d/yyyy"
        return dateformat.string(from: date)
    }
}
