//
//  CocktailViewController.swift
//  Mixit
//
//  Created by Telematica on 3/6/20.
//  Copyright © 2020 Cristhian Bolaños. All rights reserved.
//

import UIKit

class CocktailViewController: UIViewController{
    
    var delegate: CocktailViewControllerDelegate?
    var cocktail: Cocktail?
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var tutorialLabel: UILabel!
    
    @IBOutlet weak var ingredientsLabel: UILabel!
    
    @IBOutlet weak var randomButton: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let cocktail = cocktail {
            descriptionLabel.text = cocktail.description
            tutorialLabel.text = cocktail.description
            navigationItem.title = cocktail.title
            randomButton.isHidden = true
            var ingredients = ""
            if cocktail.ingredients.count > 0 {
                for ingredient in cocktail.ingredients{
                    ingredients = ingredients + ingredient + "\n"
                }
                ingredientsLabel.text = ingredients
            } else{
                ingredientsLabel.text = ""
            }
            
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //Method to dismiss the current scene
    func dismissMe(){
        dismiss(animated: true, completion: nil)
    }
    
}
