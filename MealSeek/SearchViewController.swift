//
//  SearchViewController.swift
//  MealSeek
//
//  Created by Zhanat on 08.11.17.
//  Copyright © 2017 KBTU. All rights reserved.
//

import UIKit
import Firebase

class SearchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var rootRef: DatabaseReference! = nil
    var ingredients:[Ingredient] = []
    var choosenIngredients:[Ingredient] = []
    @IBOutlet weak var tableView: UITableView!
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
        
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ingredients.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:
            "IngredientCell", for: indexPath) as? IngredientCell
        cell?.label.text = ingredients[indexPath.row].name
        return cell!
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
