//
//  TodoCell.swift
//  Todoey
//
//  Created by James Richardson on 5/30/20.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class ToDoItem {
    var id: Int
    var itemTitle : String
    var itemColor : CGColor
    var checked : Bool
    
    init(id: Int, itemTitle: String, itemColor: CGColor, isChecked: Bool){
        self.id = id
        self.itemTitle = itemTitle
        self.itemColor = itemColor
        self.checked = isChecked
    }
    
}
