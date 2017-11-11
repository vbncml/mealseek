//
//  SearchViewController.swift
//  MealSeek
//
//  Created by Zhanat on 08.11.17.
//  Copyright © 2017 KBTU. All rights reserved.
//

import UIKit
import Firebase

class SearchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    var rootRef: DatabaseReference! = nil
    var ingredients:[Ingredient] = []
    var choosenIngredients:[Ingredient] = []
    var filteredIngredients:[Ingredient] = []
    var isSearching = false
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var chTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        rootRef = Database.database().reference()
        let itemsRef = rootRef.child("ingredients")
        itemsRef.observe(DataEventType.value, with: { (snapshot) in
            for ingredient in snapshot.children.allObjects as![DataSnapshot]{
                let ingredientObject = ingredient.value as? [String: AnyObject]
                let ingredientName = ingredientObject?["name"] as? String ?? ""
                let ingredientAmount = ingredientObject?["amount"] as? String ?? ""
                let ingredientUnits = ingredientObject?["units"] as? String ?? ""
                let ingredientId = ingredientObject?["id"] as? String ?? ""
                self.ingredients.append(Ingredient(id: ingredientId, name: ingredientName, amount: ingredientAmount, units: ingredientUnits))
            }
        self.tableView.reloadData()
        }) { (error) in
            print(error.localizedDescription)
        
        }
        searchBar.delegate = self
        searchBar.returnKeyType = UIReturnKeyType.done
        
        
    }
    
    @IBAction func findRecipeBtnTapped(_ sender: Any) {
        // go to listOfRecipes ViewController
    }
    
    @IBAction func removeIngredientBtnTapped(_ sender: Any){
        //remove from chIngredientsList
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if (tableView == tableView){
            if isSearching
            {
                return filteredIngredients.count
            }
            else {
            return ingredients.count
            }
        }
        if (tableView == chTableView){
            return choosenIngredients.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if (tableView == tableView){
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
                "ChoosenIngredientCell", for: indexPath) as? ChoosenIngredientCell
            cell?.label.text = choosenIngredients[indexPath.row].name
            return cell!
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.choosenIngredients.append(ingredients[indexPath.row-1])
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if (searchBar.text == nil || searchBar.text == ""){
            isSearching = false
            
            view.endEditing(true)
            tableView.reloadData()
        }
        else{
            isSearching = true
            filteredIngredients = ingredients.filter({$0.name == searchBar.text!})
            tableView.reloadData()
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        if isSearching {
            self.tableView.isHidden = false
            self.chTableView.isHidden = true
        }
        else {
            self.tableView.isHidden = true
            self.chTableView.isHidden = false
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
