//
//  ViewController.swift
//  Todoey
//
//  Created by Ahmed Danial Arab on 2/7/18.
//  Copyright © 2018 Ahmed Danial. All rights reserved.
//

import UIKit

class ToDoViewController: UITableViewController {

    var itemArray = [String]()
    var defaults = UserDefaults.standard
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let items = defaults.array(forKey: "ToDoListArray") as? [String] {
            itemArray = items
        }
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    //MARK: - TableView Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        cell.textLabel?.text = itemArray[indexPath.row]
        return cell
    }
    
    //MARK: - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        }
        else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //MARK: - Add New Items
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        let alert = UIAlertController(title: "Add Todoey Item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            //When user clicks addItem Button
            print("Success!")
            if !(textField.text?.trimmingCharacters(in: .whitespaces).isEmpty)! {
            self.itemArray.append(textField.text!)
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

