//
//  RecipeDetailViewController.swift
//  MealSeek
//
//  Created by Zhanat on 19.11.17.
//  Copyright © 2017 KBTU. All rights reserved.
//

import UIKit

class RecipeDetailViewController: UIViewController {
    
    var recipe:Recipe? = nil
    var ingredientsList :[Ingredient] = []
    var str = ""
  
    @IBOutlet weak var mealImage: UIImageView!
    @IBOutlet weak var ingredientsLabel: UILabel!
    @IBOutlet weak var mealNameLabel: UILabel!
    @IBOutlet weak var recipeImage: UIImageView!
    
    @IBOutlet weak var instructionLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        recipeImage.image = UIImage(named:"recipe")
        
        for ingr in ingredientsList{
            str += ingr.name + " " + String(ingr.amount) + " " + ingr.units + "\n"
        }
        
        mealNameLabel.text = recipe?.mealName
        instructionLabel.text = recipe?.instruction
        ingredientsLabel.text = str
        mealImage.image = UIImage(named:(recipe?.imageUrl)!)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
