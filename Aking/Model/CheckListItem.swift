//
//  CheckListItem.swift
//  Aking
//
//  Created by Usama Sadiq on 4/17/20.
//  Copyright © 2020 Usama Sadiq. All rights reserved.
//

import UIKit

struct CheckListItem {
    var note: Note
    var items: [Item]
    
    init() {
        note = Note(description: "", color: .clear)
        items = []
    }
    init(description: String, items: [Item], color: UIColor) {
        self.note = Note(description: description, color: color)
        self.items = items
    }
}
 
struct Item {
    var title: String
    var status: Bool
}