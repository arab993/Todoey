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
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Item.plist")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
         print(dataFilePath!)
       
        loadItems()
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
        
        saveItems()
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
                
            self.saveItems()
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
    func saveItems() {
        let encoder = PropertyListEncoder()
        do {
            let data = try encoder.encode(self.itemArray)
            try data.write(to: self.dataFilePath!)
        }catch { print("Error in encoding \(error)")}
        self.tableView.reloadData()
    }
    
    func loadItems() {
        if let data = try? Data(contentsOf: dataFilePath!) {
            let decoder = PropertyListDecoder()
            do {
            itemArray = try decoder.decode([Item].self, from: data)
            } catch { print("Error decoding into array \(error)") }
            
        }
    }
}

