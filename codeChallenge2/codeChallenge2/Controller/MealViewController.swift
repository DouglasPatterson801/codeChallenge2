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
    var currentDate = Date()
    let dateFormatter = DateFormatter()
    let formatTemplate = "MMMM dd, yyyy"
    var toggle: Bool = true
    
    
    //==================================================
    // MARK: - Outlets
    //==================================================
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var datePickerStackView: UIStackView!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var expanderButton: UIButton!
    @IBOutlet weak var remainingOutletsStackView: UIStackView!
    @IBOutlet weak var mealTextField: UITextField!
    @IBOutlet weak var calorieTextField: UITextField!
    @IBOutlet weak var ratingSlider: UISlider!
    @IBOutlet weak var ratingNumberLabel: UILabel!
    
    
    //==================================================
    // MARK: - View Lifecycle
    //==================================================
    
    override func viewDidLoad() {
        super.viewDidLoad()
        datePicker.maximumDate = currentDate
        dateLabel.text = formatCurrentDate()
        datePickerStackView.isHidden = true
        remainingOutletsStackView.transform = CGAffineTransform(translationX: 0, y: -216)
        
    }
    
    //==================================================
    // MARK: - Functions
    //==================================================
    
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
    
    //==================================================
    // MARK: - Actions
    //==================================================
    
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
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
