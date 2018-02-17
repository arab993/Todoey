//
//  ViewController.swift
//  Todoey
//
//  Created by Ahmed Danial Arab on 2/7/18.
//  Copyright © 2018 Ahmed Danial. All rights reserved.
//

import UIKit

class ToDoViewController: UITableViewController {

    var itemArray = [Item]()
    
    var defaults = UserDefaults.standard
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        if let items = defaults.array(forKey: "ToDoListArray") as? [String] {
//            itemArray = items
//        }
        
        let newItem = Item()
        newItem.title = "1st Item"
        newItem.done = true
        itemArray.append(newItem)
        
        let newItem2 = Item()
        newItem2.title = "2nd Item"
        itemArray.append(newItem2)
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    //MARK: - TableView Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        let item = itemArray[indexPath.row]
        
        cell.textLabel?.text = item.title
        
        cell.accessoryType = item.done ? .checkmark : .none
//        Above line of code is equivalent
//        if itemArray[indexPath.row].done == false {
//            cell.accessoryType = .none
//        }
//        else {
//            cell.accessoryType = .checkmark
//        }
       
        return cell
    }
    
    //MARK: - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        tableView.reloadData()
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //MARK: - Add New Items
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        let alert = UIAlertController(title: "Add Todoey Item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            //When user clicks addItem Button
            //print("Success!")
            if !(textField.text?.trimmingCharacters(in: .whitespaces).isEmpty)! {
                let newItem = Item()
                newItem.title = textField.text!
            self.itemArray.append(newItem)
                self.defaults.set(self.itemArray, forKey: "ToDoListArray")
            self.tableView.reloadData()
          //print(self.itemArray)
         }
        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel) { (cancel) in
           // print("Canceled!")
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create New Item"
            textField = alertTextField
        }
        alert.addAction(action)
        alert.addAction(cancel)
        
        present(alert, animated: true, completion: nil)
    }
}

