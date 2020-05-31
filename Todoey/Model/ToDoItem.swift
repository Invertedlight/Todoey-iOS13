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

class ToDoItem: Codable {
    var id: Int
    var itemTitle : String
    var itemColorString : String
    var isChecked : Bool
    
    init(id: Int, itemTitle: String, itemColorString: String, isChecked: Bool){
        self.id = id
        self.itemTitle = itemTitle
        self.itemColorString = itemColorString
        self.isChecked = isChecked
    }
    
}
