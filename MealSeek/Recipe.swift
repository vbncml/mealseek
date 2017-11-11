//
//  Recipe.swift
//  MealSeek
//
//  Created by Zhanat on 23.10.17.
//  Copyright © 2017 KBTU. All rights reserved.
//

class Recipe{
    
    var id: String
    var ingredients: [String]
    var instruction: String
    
    
    init(id: String, ingredients: [String], instruction: String){
        self.id = id
        self.ingredients = ingredients
        self.instruction = instruction
        
    }
    
    static func form(id: String, ingredients: [String], instruction: String)->Recipe{
        let result = Recipe(id: id, ingredients: ingredients, instruction: instruction)
        return result
    }

    
}
