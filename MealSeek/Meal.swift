//
//  Meal.swift
//  MealSeek
//
//  Created by Zhanat on 23.10.17.
//  Copyright © 2017 KBTU. All rights reserved.
//

class Meal{
    var id: String
    var name: String
    var recipe: String
   
    
    init(id: String, name: String,recipe: String){
        self.id = id
        self.name = name
        self.recipe = recipe
    }
    
    static func form(id: String, name: String, recipe: String)->Meal{
        let result = Meal(id: id, name: name, recipe: recipe)
        return result
    }

    
}
