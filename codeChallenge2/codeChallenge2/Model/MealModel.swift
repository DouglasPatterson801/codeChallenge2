//
//  MealModel.swift
//  codeChallenge2
//
//  Created by Douglas Patterson on 5/15/19.
//  Copyright © 2019 Douglas Patterson. All rights reserved.
//

import Foundation

struct Meal: Codable, Comparable {
    
    static func < (lhs: Meal, rhs: Meal) -> Bool {
        return lhs.date > rhs.date
    }
    
    var name: String
    var calories: Int
    var date: Date
    var rating: Int
    
   
    static let DocumentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("meals").appendingPathExtension("plist")
    
    static func loadFromFile() -> [Meal]? {
        guard let codedMeals = try? Data(contentsOf: ArchiveURL) else { return nil }
        let decoder = PropertyListDecoder()
        return try? decoder.decode(Array<Meal>.self, from: codedMeals)
    }
    
    static func loadSampleMeal() -> [Meal] {
        return [Meal(name: "Sample Meal", calories: 000, date: Date(), rating: 5)]
    }
    
    static func saveToFile(meals: [Meal]) {
        let encoder = PropertyListEncoder()
        let codedMeals = try? encoder.encode(meals)
        try? codedMeals?.write(to: ArchiveURL, options: .noFileProtection)
    }
    
}
