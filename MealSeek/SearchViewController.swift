//
//  SearchViewController.swift
//  MealSeek
//
//  Created by Zhanat on 08.11.17.
//  Copyright © 2017 KBTU. All rights reserved.
//

import UIKit
import Firebase

class SearchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate, UISearchDisplayDelegate {
    var rootRef: DatabaseReference! = nil
    var ingredients:[Ingredient] = []
    var chosenIngredients:[Ingredient] = []
    var filteredIngredients:[Ingredient] = []
    var isSearching = false
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var chTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var ingredientsImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ingredientsImage.image = UIImage(named:"ingredients")
        tableView.dataSource = self
        tableView.delegate = self
        chTableView.dataSource = self
        chTableView.delegate = self
        
        
        
        rootRef = Database.database().reference()
        let itemsRef = rootRef.child("ingredients")
        itemsRef.observe(DataEventType.value, with: { (snapshot) in
            for ingredient in snapshot.children.allObjects as![DataSnapshot]{
                let ingredientObject = ingredient.value as? [String: AnyObject]
                let ingredientName = ingredientObject?["name"] as? String ?? ""
                let ingredientAmount = ingredientObject?["amount"] as? String ?? ""
                let ingredientUnits = ingredientObject?["units"] as? String ?? ""
                let ingredientId = ingredientObject?["id"] as? Int ?? nil
                self.ingredients.append(Ingredient(id: ingredientId!, name: ingredientName, amount: ingredientAmount, units: ingredientUnits))
            }
            
            self.tableView.reloadData()
        }) { (error) in
            print(error.localizedDescription)
        
        }
        

        searchBar.delegate = self
        searchBar.returnKeyType = UIReturnKeyType.done
        
        self.tableView.isHidden = true
        self.chTableView.isHidden = false
        
        
    }
    
    @IBAction func findRecipeBtnTapped(_ sender: Any) {
        let _: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc : RecipesViewController = storyboard?.instantiateViewController(withIdentifier: "RecipesViewController") as! RecipesViewController
        vc.ingredients = chosenIngredients
        vc.recipeIngredients = ingredients
        let navController = UINavigationController(rootViewController: vc)
        self.present(navController, animated: true, completion: nil)
    }
    
    @IBAction func removeIngredientBtnTapped(_ sender: Any){
        let index = (sender as AnyObject).tag
        chosenIngredients.remove(at: index!)
        chTableView.reloadData()
        //remove from chIngredientsList
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if (tableView === self.tableView) {
            if isSearching {
                return filteredIngredients.count
            } else {
                return ingredients.count
            }
        } else {
            return chosenIngredients.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if (tableView === self.tableView){
            let cell = tableView.dequeueReusableCell(withIdentifier:
                "IngredientCell", for: indexPath) as? IngredientCell
                if isSearching{
                    cell?.label.text = filteredIngredients[indexPath.row].name
                }
                else {
                    cell?.label.text = ingredients[indexPath.row].name
                }
                return cell!
            }
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier:
                    "ChosenIngredientCell", for: indexPath) as? ChoosenIngredientCell
                cell?.label.text = chosenIngredients[indexPath.row].name
                return cell!
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if(!isSearching){
            self.chosenIngredients.append(ingredients[indexPath.row])
        }
        else{
            self.chosenIngredients.append(filteredIngredients[indexPath.row])
        }
        chTableView.reloadData()
        self.tableView.isHidden = true
        self.chTableView.isHidden = false
        
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        self.tableView.isHidden = false
        self.chTableView.isHidden = true
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
       
        if (searchBar.text == nil || searchBar.text == ""){
            
            isSearching = false
            
            view.endEditing(true)
            
            tableView.reloadData()
        }
        else{
            isSearching = true
            
            filteredIngredients = ingredients.filter({$0.name.lowercased().contains((searchBar.text?.lowercased())!)})

            tableView.reloadData()
            
        }
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
