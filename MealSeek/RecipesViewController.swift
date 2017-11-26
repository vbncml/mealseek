//
//  RecipesViewController.swift
//  MealSeek
//
//  Created by Zhanat on 13.11.17.
//  Copyright © 2017 KBTU. All rights reserved.
//

import UIKit
import Firebase

class RecipesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var recipesImage: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    var rootRef: DatabaseReference! = nil
    var recipes:[Recipe] = []
    var sortedRecipes: [Recipe] = []
    var ingredients:[Ingredient] = []
    var recipeIngredients:[Ingredient] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        recipesImage.image = UIImage(named:"recipe")
        tableView.delegate = self
        tableView.dataSource = self
        rootRef = Database.database().reference()
        let itemsRef = rootRef.child("recipes")
        itemsRef.observe(DataEventType.value, with: { (snapshot) in
            for recipe in snapshot.children.allObjects as![DataSnapshot]{
                let recipeObject = recipe.value as? [String: AnyObject]
                let recipeMealName = recipeObject?["mealName"] as? String ?? ""
                let recipeIngredients = recipeObject?["ingredients"] as? Array<Int> ?? []
                let recipeInstruction = recipeObject?["instruction"] as? String ?? ""
                let recipeImageUrl = recipeObject?["imageUrl"] as? String ?? "5"
                let recipeId = recipeObject?["id"] as? Int ?? 13
                self.recipes.append(Recipe(id: recipeId, mealName: recipeMealName, ingredients: recipeIngredients, instruction: recipeInstruction, imageUrl: recipeImageUrl))
            }
            
            for recipe in self.recipes{
                if ( self.ingredients.count != 0 ) {
                    for ingr in self.ingredients{
                        if (recipe.ingredients.contains(ingr.id)){
                            if !self.sortedRecipes.contains(where: { $0.mealName == recipe.mealName}){
                                self.sortedRecipes.append(recipe)
                            }
                        }
                    }
                }
                else {
                    self.sortedRecipes.append(recipe)
                }
                
            }

            
            self.tableView.reloadData()
        })
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sortedRecipes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RecipeCell") as! RecipeCell
        cell.mealNameLabel.text = sortedRecipes[indexPath.row].mealName
        cell.mealImage.image = UIImage(named:sortedRecipes[indexPath.row].imageUrl)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showDetail", sender: indexPath)
    }
    
 
    @IBAction func backBtnPressed(_ sender: Any) {
        let _: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard?.instantiateViewController(withIdentifier: "SearchViewController") as! SearchViewController
        vc.chosenIngredients = []
        let navController = UINavigationController(rootViewController: vc)
        self.present(navController, animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "showDetail"){
            let chosen = (sender as! NSIndexPath).row
            let detailsVC = segue.destination as! RecipeDetailViewController
            detailsVC.recipe = sortedRecipes[chosen]
        
            for i in sortedRecipes[chosen].ingredients{
                for ingr in self.recipeIngredients{
                    if(i == ingr.id){
                        detailsVC.ingredientsList.append(ingr)
                    }
                }
            }
        }
        else{
            let _: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard?.instantiateViewController(withIdentifier: "SearchViewController") as! SearchViewController
            vc.chosenIngredients = []
            let navController = UINavigationController(rootViewController: vc)
            self.present(navController, animated: true, completion: nil)
            
        }
    }
    
}
