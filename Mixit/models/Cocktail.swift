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
    static let defaultImage = UIImage(named: "default_image.jpg")
    var title: String
    var description: String
    var tutorial: String
    var creatorsEmail: String
    var favourite: Bool
    var prepared: Bool
    var image:UIImage{
        get {
            return image ?? Cocktail.defaultImage
        }
        set{
            image = newValue
        }
    }
    
    init(id: String, title: String, description: String, tutorial: String, creatorsEmail: String, favourite: Bool, prepared: Bool, image:UIImage? = nil){
        self.title = title
        self.description = description
        self.tutorial = tutorial
        self.creatorsEmail = creatorsEmail
        self.favourite = favourite
        self.prepared = prepared
        self.image = image
    }
}

