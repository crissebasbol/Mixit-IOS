//
//  CreateCocktailViewController.swift
//  Mixit
//
//  Created by Telematica on 3/7/20.
//  Copyright © 2020 Cristhian Bolaños. All rights reserved.
//

import UIKit

class CreateCocktailViewController: UIViewController {
    
    //Object to hold a CocktailViewControllerDelegate instance
    var delegate: CocktailViewControllerDelegate?
    
    //IngredientsManager object to handle operations over the Ingredient collection
    var ingredientsManager: IngredientsManager = IngredientsManager()
    
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var tutorialTextField: UITextField!
    @IBOutlet weak var imageCocktail: UIImageView!
    @IBOutlet weak var ingredientsView: UIView!
    
    var cocktailToSave: Cocktail = Cocktail(id: "", title: "", description: "", tutorial: "", ingredients: ["",""], creatorsEmail: "", favourite: false, prepared: false, imageUrl: "")
    var creatorEmail = ""
    var favourite = false
    var prepared = false
    var id = ""
    var ingredients: [String] = [""]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        creatorEmail = "crissebasbol@gmail.com"
    }
    
    
    @IBAction func touchSave(_ sender: UIBarButtonItem) {
        //Define a cocktail structure with scene form data
        //TODO: set emails creator
        cocktailToSave.id = id
        cocktailToSave.title = titleTextField.text!
        cocktailToSave.description = descriptionTextField.text!
        cocktailToSave.tutorial = tutorialTextField.text!
        cocktailToSave.creatorsEmail = creatorEmail
        cocktailToSave.favourite = favourite
        cocktailToSave.prepared = prepared
        cocktailToSave.ingredients = ingredients
        //Deliver the book to the CocktailViewControllerDelegate object to be sent to the next scene
        delegate?.saveCocktail(cocktailToSave)
        Utilities.dismiss(self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("Sending delegate to ingredients controller")
        if let ingredientTableViewController = segue.destination as? IngredientTableViewController{
            ingredientTableViewController.delegate = self
        }
    }
    
}

extension CreateCocktailViewController: IngredientsDelegate{
    func saveIngredients(_ ingredients: [Ingredient]){
        for (index, ingredient) in ingredients.enumerated(){
            if index != 0 {
                self.ingredients.append( ingredient.ingredient + " - " + ingredient.quantity )
            }else{
                self.ingredients[0] = ingredient.ingredient + " - " + ingredient.quantity
            }
        }
    }
}

/*Defines a delegate protocolo for navigation purposes, in this case*/
protocol CocktailViewControllerDelegate{
    func saveCocktail(_ cocktail: Cocktail)
}
