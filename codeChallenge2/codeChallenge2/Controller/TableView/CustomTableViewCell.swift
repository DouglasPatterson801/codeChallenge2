//
//  CustomTableViewCell.swift
//  codeChallenge2
//
//  Created by Douglas Patterson on 5/16/19.
//  Copyright © 2019 Douglas Patterson. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func formatPickerDate(from meal: Meal) -> String {
        let dateFormatter = DateFormatter()
        let mealDate = meal.date
        dateFormatter.dateFormat = "MMMM dd, yyyy"
        return dateFormatter.string(from: mealDate)
    }
    
    func updateCell(with meal: Meal)  {
      dateLabel.text = formatPickerDate(from: meal)
        nameLabel.text = meal.name
        ratingLabel.text = "\(meal.rating)/5"
    }
}
