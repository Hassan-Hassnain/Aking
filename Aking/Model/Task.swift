//
//  Task.swift
//  Aking
//
//  Created by Usama Sadiq on 4/18/20.
//  Copyright © 2020 Usama Sadiq. All rights reserved.
//

import UIKit


enum TaskStatus { case done, pending }
struct Task {
    var id: Int?
    var title: String
    var assigneeName: String
    var projectName: String
    var dueDate: String
    var description: String
    var members: [UIImage]
    var tag: String
    var color: UIColor
    var status: TaskStatus = .pending
    
}
