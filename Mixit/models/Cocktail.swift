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
    var image:UIImage{
        get {
            return imagen ?? Cocktail.defaulImage
        }
        set{
            imagen = newValue
        }
    }
    private var imagen: UIImage? = nil
    
    init(id: String, title: String, description: String, tutorial: String, ingredients: [String], creatorsEmail: String, favourite: Bool, prepared: Bool, image:UIImage? = nil) {
        self.id = id
        self.title = title
        self.description = description
        self.tutorial = tutorial
        self.ingredients = ingredients
        self.creatorsEmail = creatorsEmail
        self.favourite = favourite
        self.prepared = prepared
        self.imagen = image
    }
}

