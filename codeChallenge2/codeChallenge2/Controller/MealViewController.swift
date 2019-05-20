//
//  MealViewController.swift
//  codeChallenge2
//
//  Created by Douglas Patterson on 5/15/19.
//  Copyright © 2019 Douglas Patterson. All rights reserved.
//

import UIKit

class MealViewController: UIViewController {
    
    //==================================================
    // MARK: - Properties
    //==================================================
    
    var meal: Meal?
    var currentDate = Date()
    var dateFormatter = DateFormatter()
    let formatTemplate = "MMMM dd, yyyy"
    var toggle: Bool = true
    
    //==================================================
    // MARK: - Outlets
    //==================================================
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var datePickerStackView: UIStackView!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var expanderButton: UIButton!
    @IBOutlet weak var remainingOutletsStackView: UIStackView!
    @IBOutlet weak var mealTextField: UITextField!
    @IBOutlet weak var calorieTextField: UITextField!
    @IBOutlet weak var ratingSlider: UISlider!
    @IBOutlet weak var ratingNumberLabel: UILabel!
    @IBOutlet weak var warningLabelStackView: UIStackView!
    @IBOutlet weak var missingNameLabel: UILabel!
    @IBOutlet weak var missingRatingLabel: UILabel!
    
    
    //==================================================
    // MARK: - View Lifecycle
    //==================================================
    
    override func viewDidLoad() {
        super.viewDidLoad()
        datePicker.maximumDate = currentDate
        dateLabel.text = formatCurrentDate()
        datePickerStackView.isHidden = true
        remainingOutletsStackView.transform = CGAffineTransform(translationX: 0, y: -216)
        warningLabelStackView.transform = CGAffineTransform(translationX: 0, y: -216)
        warningLabelStackView.isHidden = true
        
        if let meal = meal {
            dateLabel.text = formatMealDate()
            mealTextField.text = meal.name
            calorieTextField.text = "\(meal.calories)"
            ratingNumberLabel.text = "\(meal.rating)"
        }
    }
    
    //==================================================
    // MARK: - Functions
    //==================================================
    
    
    func formatMealDate() -> String {
        guard let mealDate = meal?.date else {
        return formatCurrentDate()
        }
        dateFormatter.dateFormat = formatTemplate
        return dateFormatter.string(from: mealDate)
    }
    
    func formatCurrentDate() -> String {
        let currentDate = Date()
        dateFormatter.dateFormat = formatTemplate
        return dateFormatter.string(from: currentDate)
    }
    
    func formatPickerDate() -> String {
        let pickerDate = datePicker.date
        dateFormatter.dateFormat = "MMMM dd, yyyy"
        return dateFormatter.string(from: pickerDate)
    }
    
    func getDateFromLabel() -> Date {
        self.dateFormatter.dateFormat = "MMMM dd, yyyy"
        guard let dateLabelText = dateLabel.text,
        let date = dateFormatter.date(from: "\(dateLabelText)") else { return Date() }
        return date
    }
    
    
    
    func collapsePickerStackView() {
        UIView.animate(withDuration: 0.3, animations: {
            self.datePickerStackView.alpha = 0.0
            self.remainingOutletsStackView.transform = CGAffineTransform(translationX: 0, y: -216)
            self.expanderButton.transform = .identity
        }) { (Bool) in
            self.datePickerStackView.isHidden = true
        }
    }
    
    func expandPickerStackView() {
        UIView.animate(withDuration: 0.3) {
            self.datePickerStackView.alpha = 1.0
            self.remainingOutletsStackView.transform = CGAffineTransform(translationX: 0, y: 0)
            self.expanderButton.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
            self.datePickerStackView.isHidden = false
        }
    }
    
    func convertCalorieTextToInt() -> Int {
        guard let calText = calorieTextField.text,
        let calInt = Int(calText) else { return 0 }
        return calInt
        
    }
    
    func convertRatingTextToInt() -> Int {
        guard let ratingText = ratingNumberLabel.text,
            let ratingIng = Int(ratingText) else { return 0 }
        return ratingIng
    }
    
    
    //==================================================
    // MARK: - Actions
    //==================================================
    
    
    @IBAction func editingChanged(_ sender: UITextField) {
    }
    
    
    @IBAction func datePickerChanged(_ sender: Any) {
        dateLabel.text = formatPickerDate()
    }
    
    @IBAction func expanderButtonTapped(_ sender: Any) {
        if toggle == true {
            expandPickerStackView()
            expanderButton.titleLabel?.text = "Choose"
            toggle = false
        } else if toggle == false {
            collapsePickerStackView()
            expanderButton.titleLabel?.text = "Change"
            toggle = true
        }
    }
    @IBAction func sliderMoved(_ sender: Any) {
        ratingNumberLabel.text = "\(Int(ratingSlider.value.rounded()))"
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
       
    }
    
    //==================================================
    // MARK: - Navigation
    //==================================================
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        guard segue.identifier == "saveUnwind" else { return }
        
        let date = getDateFromLabel()
        guard let name = mealTextField.text else { return }
        let calories = convertCalorieTextToInt()
        let rating = convertRatingTextToInt()
        
        meal = Meal(name: name, calories: calories, date: date, rating: rating)
        
    }
}
