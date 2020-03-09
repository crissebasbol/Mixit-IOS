//
//  IngredientsCocktailViewController.swift
//  Mixit
//
//  Created by Telematica on 3/7/20.
//  Copyright © 2020 Cristhian Bolaños. All rights reserved.
//

import UIKit

class IngredientsCocktailViewController: UIViewController {
    
    var delegate: IngredientsDelegate?

    @IBOutlet weak var tableView: UITableView!
    
    var ingredients: [Ingredient] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if ingredients.count == 0 {
            ingredients.append(createEmptyIngredient())
        }
        
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    public func addEmptyIngredient() {
        ingredients.append(createEmptyIngredient())
        tableView.reloadData()
    }
    func createEmptyIngredient() -> Ingredient{
        
        return Ingredient(ingredient: "", quantity: "")
    }
    
    
    @IBAction func btnAddIngredient(_ sender: UIButton) {
        addEmptyIngredient()
    }
    
}

extension IngredientsCocktailViewController: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ingredients.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ingredient") as! IngredientCellTableViewCell
        
        ingredients[indexPath.row].ingredient = cell.getIngredient()
        ingredients[indexPath.row].quantity = cell.getQuantity()
        
        let ingredient: Ingredient = ingredients[indexPath.row]
                
        cell.setIngredient(ingredient: ingredient)
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let ingredientsCocktailViewController = segue.source as? MyCocktailsTableViewController{
            //saveIngredients(ingredientsCocktailViewController.ingredients)
            print("Entro--------")
        }
        print("No-Entro--------")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
    }
    
    
}
