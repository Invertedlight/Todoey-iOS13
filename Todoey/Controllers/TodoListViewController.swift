//
//  ViewController.swift
//  Todoey
//
//  Created by Philipp Muellauer on 02/12/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {
    
    //var itemArray : [ToDoItem] = []
    /*       ToDoItem(id: 1, itemTitle: "Buy Eggos", itemColor: CGColor(srgbRed: CGFloat(Float.random(in: 0.3...0.8)) ,
     green: CGFloat(Float.random(in: 0.3...0.8)) ,
     blue: CGFloat(Float.random(in: 0.3...0.8)) ,
     alpha: 1.0)),
     ToDoItem(id: 2, itemTitle: "Stop Gorgon", itemColor: CGColor(srgbRed: CGFloat(Float.random(in: 0.3...0.8)) ,
     green: CGFloat(Float.random(in: 0.3...0.8)) ,
     blue: CGFloat(Float.random(in: 0.3...0.8)) ,
     alpha: 1.0)),
     ToDoItem(id: 3, itemTitle: "Find Fred", itemColor: CGColor(srgbRed: CGFloat(Float.random(in: 0.3...0.8)) ,
     green: CGFloat(Float.random(in: 0.3...0.8)) ,
     blue: CGFloat(Float.random(in: 0.3...0.8)) ,
     alpha: 1.0))
     ]*/
    
    var itemArray: [ToDoItem] = []
    
    var storage : [[String]] = []
    
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        //defaults.removeObject(forKey: "ToDoListStorage")
        // Check to see if the storage default is empty
        if self.defaults.array(forKey: "ToDoListStorage") != nil {
            storage = (self.defaults.array(forKey: "ToDoListStorage") as? [[String]])!
        }
        //print(storage)
        for array in storage {
            if array.count != 0 {
                //print("ARRAY: \(array)")
                let id = array[0]
                let name = array[1]
                let red = array[2]
                let green = array[3]
                let blue = array[4]
                let checked = array[5]
                
                var isChecked = false
                if checked == "true" {
                     isChecked = true
                } else {
                     isChecked = false
                }
                
                // print("\(id)  \(name)  \(red)  \(green)  \(blue)")
                let newItem = ToDoItem(id: Int(id)!, itemTitle: name, itemColor: CGColor(srgbRed: CGFloat(Float(red)!), green: CGFloat(Float(green)!), blue: CGFloat(Float(blue)!), alpha: 1.0), isChecked: isChecked)
                self.itemArray.append(newItem)
            }
            
            
            
            // let newItem = ToDoItem(id: itemID, itemTitle: itemName, itemColor: CGColor(srgbRed: CGFloat(itemRed), green: CGFloat(itemGreen), blue: CGFloat(itemBlue), alpha: 1.0))
            // itemArray.append(newItem)
        }
        
    }
    
    //MARK: - TableView DataSource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let todoItem = itemArray[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        cell.textLabel?.text = todoItem.itemTitle
        cell.textLabel?.backgroundColor = UIColor(cgColor: todoItem.itemColor)
        cell.accessoryType = todoItem.checked == true ? .checkmark : .none
        return cell
        
    }
    
    //MARK: - TableView Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        itemArray[indexPath.row].checked = !itemArray[indexPath.row].checked
        updateStoreage()
        tableView.deselectRow(at: indexPath, animated: true)
        tableView.reloadData()
    }
    
    //MARK: - Add New Item
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            // what will happen once user clicks add item button
            let itemID = self.itemArray.count
            let itemTitle = textField.text!
            let itemRed = Float.random(in: 0.3...0.8)
            let itemGreen = Float.random(in: 0.3...0.8)
            let itemBlue = Float.random(in: 0.3...0.8)
            
            self.itemArray.append(ToDoItem(id: itemID ,
                                           itemTitle: itemTitle,
                                           itemColor: CGColor(srgbRed: CGFloat(itemRed) ,
                                                              green: CGFloat(itemGreen) ,
                                                              blue: CGFloat(itemBlue) ,
                                                              alpha: 1.0), isChecked: false))
            
            
            self.storage.append([String(itemID), itemTitle, String(itemRed), String(itemGreen), String(itemBlue), String(false) ])
            print(self.storage)
            self.defaults.set(self.storage, forKey: "ToDoListStorage")
            
            self.tableView.reloadData()
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create New Item"
            textField = alertTextField
        }
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func clearListPressed(_ sender: UIBarButtonItem) {
        itemArray = []
        defaults.removeObject(forKey: "ToDoListStorage")
        updateStoreage()
        self.tableView.reloadData()
    }
    
    func updateStoreage() {
        self.storage = []
        print("STORAGE: \(self.storage)")
        self.defaults.removeObject(forKey: "ToDoListStorage")
        for array in itemArray {
            let colorComponents = array.itemColor.components
            let red = colorComponents![0]
            let green = colorComponents![1]
            let blue = colorComponents![2]
            //let alpha = colorComponents![3]
            
            self.storage.append([String(array.id),
                                 array.itemTitle,
                                 String(Float(red)),
                                 String(Float(green)),
                                 String(Float(blue)),
                                 String(array.checked) ])
        }
        self.defaults.set(self.storage, forKey: "ToDoListStorage")
    }
}

