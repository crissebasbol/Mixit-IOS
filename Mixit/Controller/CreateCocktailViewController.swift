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
    
    //fundamental to save the reference
    var imagePickerController: UIImagePickerController?
    
    
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
    var selectedImage: UIImage? {
        get {
            return self.imageCocktail.image
        }
        set{
            switch newValue {
            case nil:
                self.imageCocktail.image = #imageLiteral(resourceName: "default_image")
            default:
                self.imageCocktail.image = newValue
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        creatorEmail = "crissebasbol@gmail.com"
        let gesture = UITapGestureRecognizer.init(target: self, action: #selector(selectImage))
        gesture.numberOfTapsRequired = 1
        imageCocktail.addGestureRecognizer(gesture)
    }
    
    @objc func selectImage(){
        print("Select image touched")
        
        if self.imagePickerController !=  nil {
            self.imagePickerController?.delegate = nil
            self.imagePickerController = nil
        }
        
        self.imagePickerController = UIImagePickerController.init()
        
        let alert = UIAlertController.init(title: "Select source type", message: nil, preferredStyle: .actionSheet)
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            alert.addAction(UIAlertAction.init(title: "Camera", style: .default, handler: { ( _ ) in
                self.presentImagePicker(controller: self.imagePickerController!, source: .camera)
            }))
        }
        
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            alert.addAction(UIAlertAction.init(title: "Photo library", style: .default, handler: { ( _ ) in
                self.presentImagePicker(controller: self.imagePickerController!, source: .photoLibrary)
            }))
        }
        
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum) {
            alert.addAction(UIAlertAction.init(title: "Saved albums", style: .default, handler: { ( handler ) in
                self.presentImagePicker(controller: self.imagePickerController!, source: .savedPhotosAlbum)
            }))
        }
        
        alert.addAction(UIAlertAction.init(title: "Cancel", style: .cancel, handler: { (handler) in
            
        }))
        
        self.present(alert, animated: true)
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
        cocktailToSave.isComplete = true
        //Deliver the book to the CocktailViewControllerDelegate object to be sent to the next scene
        delegate?.saveCocktail(cocktailToSave, saveFirebase: true)
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

extension CreateCocktailViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else{
            return self.imagePickerControllerDidCancel(picker)
        }
        
        self.selectedImage = image
        
        picker.dismiss(animated: true) {
            //clean up
            picker.delegate = nil
            self.imagePickerController = nil
        }
    }
    
    //helper method
    internal func presentImagePicker(controller: UIImagePickerController, source: UIImagePickerController.SourceType){
        controller.delegate = self
        controller.sourceType = source
        self.present(controller, animated: true)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true) {
            //remove picker controller, for not get any memory leaks
            picker.delegate = nil
            self.imagePickerController = nil
        }
    }
    
}


/*Defines a delegate protocolo for navigation purposes, in this case*/
protocol CocktailViewControllerDelegate{
    func saveCocktail(_ cocktail: Cocktail, saveFirebase: Bool)
    func updateCocktails(_ queryParams: [String: String])
}
