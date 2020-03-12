//
//  cocktail.swift
//  Mixit
//
//  Created by Telematica on 3/4/20.
//  Copyright © 2020 Cristhian Bolaños. All rights reserved.
//

import UIKit

struct Cocktail{
    var id: String
    static let defaulImage = UIImage(named: "default_image.jpg")!
    var title: String
    var description: String
    var tutorial: String
    var creatorsEmail: String
    var ingredients: [String]
    var favourite: Bool
    var prepared: Bool
    var imageUrl: String
    var image:UIImage{
        get {
            return imagen ?? Cocktail.defaulImage
        }
        set{
            imagen = newValue
            imageUpdated = true
        }
    }
    
    var dictionary: [String: Any] {
        return [
            "id": id,
            "title": title,
            "description": description,
            "tutorial": tutorial,
            "ingredients": ingredients,
            "imageUrl": imageUrl
        ]
    }
    var nsDictionary: NSDictionary {
        return dictionary as NSDictionary
    }
    
    private var imagen: UIImage? = nil
    
    public var imageUpdated = false
    public var isComplete = false
    
    init(id: String, title: String, description: String, tutorial: String, ingredients: [String], creatorsEmail: String, favourite: Bool, prepared: Bool, image:UIImage? = nil, imageUrl: String) {
        self.id = id
        self.title = title
        self.description = description
        self.tutorial = tutorial
        self.ingredients = ingredients
        self.creatorsEmail = creatorsEmail
        self.favourite = favourite
        self.prepared = prepared
        self.imagen = image
        self.imageUrl = imageUrl
    }
    
    static func parseDictionaries(dictionaries: [Any]) -> [Cocktail]{
        var cocktails = [Cocktail]()
        for dictionary in dictionaries {
            let dict = dictionary as? [String: Any]
            let id = dict!["id"] as! String
            let title = dict!["title"] as! String
            let description = dict!["description"] as! String
            let tutorial = dict!["tutorial"] as! String
            let ingredients = dict!["ingredients"] as! [String]
            var cocktail: Cocktail?
            cocktail = Cocktail(
                id: id,
                title: title,
                description: description,
                tutorial: tutorial,
                ingredients: ingredients,
                creatorsEmail: "creators",
                favourite: true,
                prepared: false,
                imageUrl: ""
            )
            cocktail?.isComplete = false
            cocktails.append(cocktail!)
        }
        return cocktails
    }
    
    static func parseIngredients(cocktail: [String: Any]) -> [String] {
        var ingredients = [String]()
        
        for index in 1...15 {
            if (!((cocktail["strIngredient\(index)"]) is NSNull)) {
                
                if (!((cocktail["strMeasure\(index)"]) is NSNull)) {
                    ingredients.append("\(cocktail["strIngredient\(index)"]!)".trimmingCharacters(in: .whitespacesAndNewlines)+" - "+"\(cocktail["strMeasure\(index)"]!)".trimmingCharacters(in: .whitespacesAndNewlines))
                    
                } else {
                    ingredients.append("\(ingredients) \(cocktail["strIngredient\(index)"]!)".trimmingCharacters(in: .whitespacesAndNewlines))
                }
            } else {
                break
            }
        }
        return ingredients
    }
    
    static func parseDescription(cocktail: [String: Any]) -> String {
        var description = ""
        
        if (!(cocktail["strCategory"] is NSNull)) {
             description = description + (cocktail["strCategory"] as? String)!.trimmingCharacters(in: .whitespacesAndNewlines)+"\n"
        }
        if (!(cocktail["strIBA"] is NSNull)) {
            description = description + (cocktail["strIBA"] as? String)!.trimmingCharacters(in: .whitespacesAndNewlines)+"\n"
        }
        if (!(cocktail["strAlcoholic"] is NSNull)) {
            description = description + (cocktail["strAlcoholic"] as? String)!.trimmingCharacters(in: .whitespacesAndNewlines)+"\n"
        }
        if (!(cocktail["strGlass"] is NSNull)) {
            description = description + (cocktail["strGlass"] as? String)!.trimmingCharacters(in: .whitespacesAndNewlines)+"\n"
        }
        
        return description
    }
}

