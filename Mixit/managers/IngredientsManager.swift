//
//  IngredientsManager.swift
//  Mixit
//
//  Created by Telematica on 3/9/20.
//  Copyright © 2020 Cristhian Bolaños. All rights reserved.
//

import Foundation

class IngredientsManager {
    
    //Store the ingredients collection
    public var ingredients: [Ingredient] = []
    
    //Store the number of ingredients in the collection
    var ingredientsCount: Int {return ingredients.count}
    
    //Get a ingredient from the collection at a specific position
    func getIngredient(at index: Int)->Ingredient{
        
        return ingredients[index]
    }
    
    func addIngredient(ingredient: Ingredient){
        ingredients.append(ingredient)
    }
    
}
