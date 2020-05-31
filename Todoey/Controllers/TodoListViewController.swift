//
//  ViewController.swift
//  Todoey
//
//  Created by Philipp Muellauer on 02/12/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {
    
    var itemArray: [ToDoItem] = []
    var storage : [[String]] = []
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        // Check to see if the storage default is empty
        if self.defaults.array(forKey: "ToDoListStorage") != nil {
            self.storage = (self.defaults.array(forKey: "ToDoListStorage") as? [[String]])!
            // print("DidLoad: \(self.storage)")
        }
        for array in storage {
            if array.count != 0 {
                let id = array[0]
                let name = array[1]
                let red = array[2]
                let green = array[3]
                let blue = array[4]
                let isChecked = array[5] == "true" ? true : false
                let newItem = ToDoItem(id: Int(id)!, itemTitle: name, itemColor: CGColor(srgbRed: CGFloat(Float(red)!), green: CGFloat(Float(green)!), blue: CGFloat(Float(blue)!), alpha: 1.0), isChecked: isChecked)
                self.itemArray.append(newItem)
            }
        }
        tableView.reloadData()
    }
    
    //MARK: - TableView DataSource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let todoItem = itemArray[indexPath.row]
        let backgroundColor = UIColor(cgColor: todoItem.itemColor)
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        cell.textLabel?.text = todoItem.itemTitle
        cell.textLabel?.backgroundColor = backgroundColor
        cell.backgroundColor = backgroundColor
        //print(todoItem.isChecked)
        cell.accessoryType = todoItem.isChecked ? .checkmark : .none
        return cell
        
    }
    
    //MARK: - TableView Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print("Before change: \(itemArray[indexPath.row].isChecked)")
        itemArray[indexPath.row].isChecked = !itemArray[indexPath.row].isChecked
        //print("After change: \(itemArray[indexPath.row].isChecked)")
        updateStoreage()
        //print(storage)
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
            if itemTitle != "" {
                self.itemArray.append(ToDoItem(id: itemID ,
                                               itemTitle: itemTitle,
                                               itemColor: CGColor(srgbRed: CGFloat(itemRed) ,
                                                                  green: CGFloat(itemGreen) ,
                                                                  blue: CGFloat(itemBlue) ,
                                                                  alpha: 1.0), isChecked: false))
                
                
                self.storage.append([String(itemID), itemTitle, String(itemRed), String(itemGreen), String(itemBlue), String(false) ])
                //print("Add Item: \(self.storage)")
                self.defaults.set(self.storage, forKey: "ToDoListStorage")
                
                self.storage = (self.defaults.array(forKey: "ToDoListStorage") as? [[String]])!
                //print("After Add Check: \(self.storage)")
                
                self.tableView.reloadData()
            }
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create New Item"
            textField = alertTextField
        }
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
        
    }
    
    @IBAction func clearListPressed(_ sender: UIBarButtonItem) {
        self.itemArray = []
        updateStoreage()
        self.tableView.reloadData()
    }
    
    func updateStoreage() {
        self.storage = []
        self.defaults.removeObject(forKey: "ToDoListStorage")
        for toDoItem in itemArray {
            let colorComponents = toDoItem.itemColor.components
            let red = colorComponents![0]
            let green = colorComponents![1]
            let blue = colorComponents![2]
            // print("ToDoItem:\(toDoItem.isChecked)")            //let alpha = colorComponents![3]
            
            self.storage.append([String(toDoItem.id),
                                 toDoItem.itemTitle,
                                 String(Float(red)),
                                 String(Float(green)),
                                 String(Float(blue)),
                                 String(toDoItem.isChecked) ])
        }
        // print("Storage:\(storage)")
        self.defaults.set(self.storage, forKey: "ToDoListStorage")
    }
    
    
    
}

