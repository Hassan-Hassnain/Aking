//
//  CheckListItem.swift
//  Aking
//
//  Created by Usama Sadiq on 4/17/20.
//  Copyright © 2020 Usama Sadiq. All rights reserved.
//

import UIKit

struct CheckListItem {
    var id:String
    var note: Note
    var items: [Item]
    var date: String
    
    init() {
        note = Note(description: "", color: .clear)
        items = []
        id = ""
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        date = dateFormatter.string(from: Date())
        
    }
    init(id: String, description: String, items: [Item], color: UIColor, date: String) {
        self.note = Note(description: description, color: color)
        self.items = items
        self.id = id
        self.date = date
    }
}
 

