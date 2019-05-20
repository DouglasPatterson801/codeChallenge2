//
//  MealTableViewController.swift
//  codeChallenge2
//
//  Created by Douglas Patterson on 5/15/19.
//  Copyright © 2019 Douglas Patterson. All rights reserved.
//

import UIKit

class MealTableViewController: UITableViewController {
    
    @IBOutlet weak var editButton: UIBarButtonItem!
    @IBOutlet weak var segControl: UISegmentedControl!
    
    
    var meals = [Meal]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setMealsArray()
        setEditButton()
        
        
    }
    
    
    //==================================================
    // MARK: - TableView Data Source
    //==================================================
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return meals.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomTableViewCell
   
        let meal = meals[indexPath.row]
        cell.updateCell(with: meal)
        cell.showsReorderControl = true
        return cell
    }
    
    //==================================================
    // MARK: - Functions
    //==================================================
    
    func setMealsArray() {
        if let savedMeals = Meal.loadFromFile() {
            if segControl.selectedSegmentIndex == 0 {
                meals = savedMeals.sorted(by: >)
            } else {
                meals = savedMeals
            }
        } else {
            meals = Meal.loadSampleMeal()
        }
    }
    
    func setEditButton() {
        if segControl.selectedSegmentIndex == 0 {
            editButton.isEnabled = false
        } else {
            editButton.isEnabled = true
        }
    }
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            meals.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
        Meal.saveToFile(meals: meals)
    }

    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        let movedMeal = meals.remove(at: fromIndexPath.row)
        meals.insert(movedMeal, at: to.row)
        tableView.reloadData()
        Meal.saveToFile(meals: meals)
    }
    //==================================================
    // MARK: - Actions
    //==================================================

    @IBAction func segControlChanged(_ sender: UISegmentedControl) {
        setEditButton()
        setMealsArray()
        tableView.reloadData()
    }
    
    @IBAction func editButtonTapped(_ sender: Any) {
        let tableViewEditingMode = tableView.isEditing
        
        tableView.setEditing(!tableViewEditingMode, animated: true)
    }
    
    //==================================================
    // MARK: - Navigation
    //==================================================
    
    @IBAction func unwindToTableView(segue: UIStoryboardSegue) {
        guard segue.identifier == "saveUnwind" else { return }
        let sourceVC = segue.source as! MealViewController
        
        if let meal = sourceVC.meal {
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                meals[selectedIndexPath.row] = meal
                tableView.reloadRows(at: [selectedIndexPath], with: .none)
            } else {
                let newIndexPath = IndexPath(row: meals.count, section: 0)
                meals.append(meal)
                tableView.insertRows(at: [newIndexPath], with: .automatic)
            }
        }
        Meal.saveToFile(meals: meals)
    }
  
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "editMeal" {
            let indexPath = tableView.indexPathForSelectedRow!
            let meal = meals[indexPath.row]
            let mealDetailView = segue.destination as! MealViewController
            
            mealDetailView.meal = meal
        }
    }
    

}
