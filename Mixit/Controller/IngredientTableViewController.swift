//
//  IngredientTableViewController.swift
//  Mixit
//
//  Created by Telematica on 3/9/20.
//  Copyright © 2020 Cristhian Bolaños. All rights reserved.
//

import UIKit

class IngredientTableViewController: UITableViewController {
    
    //Object to hold a CocktailViewControllerDelegate instance
    var delegate: IngredientsDelegate?
    
    var ingredients: [Ingredient] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if ingredients.count == 0 {
            ingredients.append(createEmptyIngredient())
        }
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ingredients.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ingredient") as! IngredientCellTableViewCell
        ingredients[indexPath.row].ingredient = cell.getIngredient()
        ingredients[indexPath.row].quantity = cell.getQuantity()
        
        let ingredient: Ingredient = ingredients[indexPath.row]
                
        cell.setIngredient(ingredient: ingredient)
        
        return cell
    }
    
    public func addEmptyIngredient() {
        ingredients.append(createEmptyIngredient())
        tableView.reloadData()
    }
    func createEmptyIngredient() -> Ingredient{
        
        return Ingredient(ingredient: "", quantity: "")
    }
    
       
    @IBAction func addOtherIngredient(_ sender: Any?) {
        addEmptyIngredient()
    }
    
    @IBAction func touchSave(_ sender: Any) {
        
        CATransaction.begin()
        CATransaction.setCompletionBlock({
            
            if (self.delegate == nil) {
                print("Null")
            }
            self.delegate?.saveIngredients(self.ingredients)
            
            self.navigationController!.popViewController(animated: true)
        })
        tableView.reloadData()
        CATransaction.commit()
        //delegate?.saveIngredients(ingredients)
 
    }
    
    
}

protocol IngredientsDelegate{
    func saveIngredients(_ ingredients: [Ingredient])
}
