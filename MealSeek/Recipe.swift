//
//  Recipe.swift
//  MealSeek
//
//  Created by Zhanat on 23.10.17.
//  Copyright © 2017 KBTU. All rights reserved.
//

class Recipe{
    
    var id: Int
    var mealName: String
    var ingredients: [Int]
    var instruction: String
    var imageUrl: String
    
    
    init(id: Int, mealName: String, ingredients: [Int], instruction: String, imageUrl:String){
        self.id = id
        self.mealName = mealName
        self.ingredients = ingredients
        self.instruction = instruction
        self.imageUrl = imageUrl
        
    }
    
    static func form(id: Int,mealName: String , ingredients: [Int], instruction: String, imageUrl: String)->Recipe{
        let result = Recipe(id: id, mealName: mealName, ingredients: ingredients, instruction: instruction, imageUrl: imageUrl)
        return result
    }

    
}
