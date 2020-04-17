//
//  DummyDB.swift
//  Aking
//
//  Created by Usama Sadiq on 4/16/20.
//  Copyright © 2020 Usama Sadiq. All rights reserved.
//

import UIKit

var colors: [UIColor] = [#colorLiteral(red: 0.436617732, green: 0.5095470548, blue: 0.9817432761, alpha: 1), #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1), #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1), #colorLiteral(red: 0.1764705926, green: 0.01176470611, blue: 0.5607843399, alpha: 1), #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), #colorLiteral(red: 0.9404537678, green: 0.4846215248, blue: 0.7824941278, alpha: 1), #colorLiteral(red: 0.8879843354, green: 0.5014117956, blue: 0, alpha: 1), #colorLiteral(red: 0.926155746, green: 0.9410773516, blue: 0.9455420375, alpha: 1), #colorLiteral(red: 0.3921400309, green: 0.152138263, blue: 0.1213966534, alpha: 1), #colorLiteral(red: 0.2389388382, green: 0.5892125368, blue: 0.8818323016, alpha: 1)]
var people: [Assignee] = [
    Assignee(avator: #imageLiteral(resourceName: "dummy_Avator"), name: "I fffffffffffam Assignee1", email: "dummy-1@email.com"),
    Assignee(avator: #imageLiteral(resourceName: "dummy_Avator"), name: "I am Assignee2", email: "dummy-2@email.com"),
    Assignee(avator: #imageLiteral(resourceName: "dummy_Avator"), name: "I am Assignee3", email: "dummy-3@email.com"),
    Assignee(avator: #imageLiteral(resourceName: "dummy_Avator"), name: "I am Assignee4", email: "dummy-4@email.com"),
    Assignee(avator: #imageLiteral(resourceName: "dummy_Avator"), name: "I am Assignee5", email: "dummy-5@email.com"),
    Assignee(avator: #imageLiteral(resourceName: "dummy_Avator"), name: "I am Assignee6", email: "dummy-6@email.com"),
    Assignee(avator: #imageLiteral(resourceName: "dummy_Avator"), name: "I am Assignee7", email: "dummy-7@email.com"),
    Assignee(avator: #imageLiteral(resourceName: "dummy_Avator"), name: "I am Assignee8", email: "dummy-8@email.com"),
    Assignee(avator: #imageLiteral(resourceName: "dummy_Avator"), name: "I am Assignee9", email: "dummy-9@email.com"),
    Assignee(avator: #imageLiteral(resourceName: "dummy_Avator"), name: "I am Assignee10", email: "dummy-10@email.com"),
    Assignee(avator: #imageLiteral(resourceName: "dummy_Avator"), name: "I am Assignee11", email: "dummy-11@email.com"),
    Assignee(avator: #imageLiteral(resourceName: "dummy_Avator"), name: "I am Assignee12", email: "dummy-12@email.com"),
    Assignee(avator: #imageLiteral(resourceName: "dummy_Avator"), name: "I am Assignee13", email: "dummy-13@email.com")
]

var projects: [Project] = [
    Project(color: #colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1), projectName: "Home", numberOfTasks: "10"),
    Project(color: #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1), projectName: "Team", numberOfTasks: "10"),
    Project(color: #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1), projectName: "Office Work", numberOfTasks: "10"),
    Project(color: #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1), projectName: "Entertainment", numberOfTasks: "10"),
    Project(color: #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1), projectName: "Personal", numberOfTasks: "10"),
]

var checkListItems: [CheckListItem] = [
    CheckListItem(description: "Testing", items: [Item(title: "Buy Grocery", status: false),Item(title: "Buy Milk", status: false)], color: .gray),
    CheckListItem(description: "Testing", items: [], color: .green),
    CheckListItem(description: "Testing", items: [], color: .yellow),
    CheckListItem(description: "Testing", items: [], color: .purple),
    CheckListItem(description: "Testing", items: [], color: .magenta),
    CheckListItem(description: "Testing", items: [], color: .orange)
]






