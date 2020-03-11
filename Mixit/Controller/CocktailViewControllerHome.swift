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
    
    var cocktailsAPIService: CocktailsAPIService = CocktailsAPIService()
    
    @IBOutlet weak var image: UIView!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var tutorialLabel: UILabel!
    
    @IBOutlet weak var ingredientsLabel: UILabel!
    
    @IBOutlet weak var randomButton: UIView!
    
    @IBAction func random(_ sender: Any) {
        cocktailsAPIService.random() {
            (cocktails, error) in
            
            if error != nil {
                
            } else if let cocktails = cocktails {
                self.completeView(cocktail: cocktails[0])
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        if let cocktail = cocktail {
            descriptionLabel.text = cocktail.description
            tutorialLabel.text = cocktail.description
            navigationItem.title = cocktail.title
            randomButton.isHidden = true
            var ingredients = ""
            if cocktail.ingredients.count > 0 {
                for (index, ingredient) in cocktail.ingredients.enumerated(){
                    if index+1 != cocktail.ingredients.count{
                        ingredients = ingredients + ingredient + ", "
                    } else{
                        ingredients = ingredients + ingredient + "."

                    }
                }
                ingredientsLabel.text = ingredients
            } else{
                ingredientsLabel.text = ""
            }
            
        } else {
            self.random(self)
        }
    }
    
    func completeView (cocktail: Cocktail) -> Void {
        self.descriptionLabel.text = cocktail.description
        self.tutorialLabel.text = cocktail.tutorial
        self.navigationItem.title = cocktail.title
        self.randomButton.isHidden = false
        // self.image.addSubview( UIImageView(image: cocktails[0].image))
        var ingredients = ""
        if cocktail.ingredients.count > 0 {
            for (index, ingredient) in cocktail.ingredients.enumerated(){
                if index+1 != cocktail.ingredients.count{
                    ingredients = ingredients + ingredient + ", "
                } else{
                    ingredients = ingredients + ingredient + "."
                }
            }
            self.ingredientsLabel.text = ingredients
        } else{
            self.ingredientsLabel.text = ""
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
