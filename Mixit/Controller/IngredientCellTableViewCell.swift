//
//  IngredientCellTableViewCell.swift
//  Mixit
//
//  Created by Telematica on 3/7/20.
//  Copyright © 2020 Cristhian Bolaños. All rights reserved.
//

import UIKit

class IngredientCellTableViewCell: UITableViewCell {

    @IBOutlet weak var ingredientField: UITextField!
    @IBOutlet weak var quantityField: UITextField!
    
    func setIngredient(ingredient: Ingredient){
        ingredientField.text = ingredient.ingredient
        quantityField.text = ingredient.quantity
    }
    
    func getIngredient()->String{
        return ingredientField.text ?? ""
    }
    
    func getQuantity()->String{
        return quantityField.text ?? ""
    }
    
}
