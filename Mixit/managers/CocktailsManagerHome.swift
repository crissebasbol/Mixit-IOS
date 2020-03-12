//
//  CocktailsManager.swift
//  Mixit
//
//  Created by Telematica on 3/5/20.
//  Copyright © 2020 Cristhian Bolaños. All rights reserved.
//

import UIKit

class CocktailsManager {
    
    //Store the cocktails collection
    public var cocktails: [Cocktail] = []
    
    //Store the number of cocktails in the collection
    var cocktailCount: Int {return cocktails.count}
    
    //Get a cocktail from the collection at a specific position
    func getCocktail(at index: Int)->Cocktail{
        
        return cocktails[index]
    }
    
    func addCocktail(cocktail: Cocktail){
        cocktails.append(cocktail)
    }
    
    //Return the cocktails collection
    public func loadCocktails()->[Cocktail]{
        
        return sampleCocktails()
    }
    
    //Add a cocktail to the collection of cocktails according to Cocktail structure
    private func sampleCocktails()->[Cocktail]{
        let title = "Snowball"
        let description = "Ordinary drink, Alcoholic, Highball glass"
        let tutorial = "Place one ice cube in the glass and add 1 1/2 oz of Advocaat. Fill up the glass with lemonade and decorate with a slice of lemon. Serve at once."
        let ingredients = ["Advocaat - 1 1/2 oz","Lemonade - 8-10 oz cold", "Lemon - 1slice", "Ice - cubes"]
        let creator = "System@gmail.com"
        let favourite = false
        let prepared = false
        
        var cocktails: [Cocktail] = []
        
        for index in 1...25{
            cocktails.append( Cocktail(id: String(index), title: title, description: description, tutorial: tutorial, ingredients: ingredients, creatorsEmail: creator, favourite: favourite, prepared: prepared, imageUrl: ""))
        }
        return cocktails
    }
}
