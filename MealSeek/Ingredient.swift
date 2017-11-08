//
//  Ingredient.swift
//  MealSeek
//
//  Created by Zhanat on 23.10.17.
//  Copyright © 2017 KBTU. All rights reserved.
//

class Ingredient{
    
    var id: String
    var name: String
    var amount: String
    var units: String
    
    init(id: String, name: String, amount: String, units: String){
        self.id = id
        self.name = name
        self.amount = amount
        self.units = units
    }
    
    static func form(id: String, name: String, amount: String, units: String)->Ingredient{
        let result = Ingredient(id: id, name: name, amount: amount, units: units)
        return result
    }
}
