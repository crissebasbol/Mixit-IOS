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
    
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var tutorialTextField: UITextField!
    @IBOutlet weak var imageCocktail: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    @IBAction func touchSave(_ sender: UIBarButtonItem) {
        //Define a cocktail structure with scene form data
        //TODO: set emails creator
        let cocktailToSave = Cocktail(id: "", title: titleTextField.text!, description: descriptionTextField.text!, tutorial: tutorialTextField.text!, ingredients: ["",""], creatorsEmail: "crissebasbol@gmail.com", favourite: false, prepared: false)
        //Deliver the book to the CocktailViewControllerDelegate object to be sent to the next scene
        delegate?.saveCocktail(cocktailToSave)
        if self.navigationController != nil{
            navigationController?.popViewController(animated: true)
        }
    }
    
}

/*Defines a delegate protocolo for navigation purposes, in this case*/
protocol CocktailViewControllerDelegate{
    func saveCocktail(_ cocktail: Cocktail)
}
