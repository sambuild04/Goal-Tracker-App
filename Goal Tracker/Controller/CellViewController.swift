//
//  CellViewController.swift
//  Goal Tracker
//
//  Created by Sam  on 5/27/19.
//  Copyright © 2019 Sam. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift
import SwipeCellKit

class CellViewController: SwipeTableViewController {
    
    let realm = try! Realm()
    
    var goalItem: Results<item>?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        loadItem()
        tableView.separatorStyle = .none
        
    }
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "goToNewIdeaCreation", sender: self)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToNewIdeaCreation" {
        
        let newIdea = segue.destination as! NewIdeaCreation
            newIdea.delegate = self
            
        }
    }
    
    
    // Data Source Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return goalItem?.count ?? 1
    }
    
    func uiColorFromHex(rgbValue: Int) -> UIColor {
        
        let red =   CGFloat((rgbValue & 0xFF0000) >> 16) / 0xFF
        let green = CGFloat((rgbValue & 0x00FF00) >> 8) / 0xFF
        let blue =  CGFloat(rgbValue & 0x0000FF) / 0xFF
        let alpha = CGFloat(1.0)
        
        return UIColor(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = super.tableView(tableView, cellForRowAt: indexPath)

        if let item = goalItem?[indexPath.row]{
            cell.textLabel?.text = item.name
            cell.accessoryType = item.done ? .checkmark : .none
            let itemColor = uiColorFromHex(rgbValue: Int(item.color) ?? 000000)
//            print("The itemColor is \(itemColor)")
            cell.backgroundColor = itemColor
        } else {
            cell.textLabel?.text = "No Items Added Yet"
        }
        
        return cell
    }
    
    //Mark: - TableView Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let item = goalItem?[indexPath.row]{
            do {
                try realm.write {
                    item.done = !item.done
                }
                
            } catch {
                print ("Error updating item, \(error)")
            }
        }
        tableView.reloadData()
        tableView.deselectRow(at: indexPath, animated: true)

        }
    
    //Mark: - Delete Data from Swipe
    override func updateModel(at indexPath: IndexPath){
        if let itemForDeletion = self.goalItem?[indexPath.row]{
            do {
                try self.realm.write {
                    self.realm.delete(itemForDeletion)
                }
            } catch {
                print("\(error)")
            }
        }
    }
    
    
    
    func loadItem(){
        goalItem = realm.objects(item.self)

        tableView.reloadData()
    }
    
}

extension CellViewController: AddItemDelegate {
    func addItem(item: item) {
            do{
                try self.realm.write {
                    self.realm.add(item)
                }
            } catch {
                print ("error adding \(error)")
            }
            self.tableView.reloadData()
    }
    

}
