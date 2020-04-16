//
//  CheckListItem.swift
//  Aking
//
//  Created by Usama Sadiq on 4/17/20.
//  Copyright © 2020 Usama Sadiq. All rights reserved.
//

import UIKit

struct CheckListItem {
    var description: String
    var items: [Item]
    var color: UIColor
    
    init() {
        description = ""
        items = []
        color = UIColor.clear
    }
}
 
struct Item {
    var title: String
    var status: Bool
}
