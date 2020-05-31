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

class ToDoItem: Encodable {
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

public extension UIColor{

    var codedString: String?{
        do{
            let data = try NSKeyedArchiver.archivedData(withRootObject: self, requiringSecureCoding: true)

            return data.base64EncodedString()

        }
        catch let error{
            print("Error converting color to coded string: \(error)")
            return nil
        }
    }


    static func color(withCodedString string: String) -> UIColor?{
        guard let data = Data(base64Encoded: string) else{
            return nil
        }

        return try? NSKeyedUnarchiver.unarchivedObject(ofClass: UIColor.self, from: data)

    }
}
/*
var color = UIColor(red: 0.5, green: 0.2, blue: 0.8, alpha: 2.0)
print (color)
print(color.codedString)
var colorString = color.codedString!
 
 UIColor().color(withCodedString: itemColorString)
 
*/
