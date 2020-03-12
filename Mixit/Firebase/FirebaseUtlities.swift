//
//  FirebaseUtlities.swift
//  Mixit
//
//  Created by Telematica on 3/11/20.
//  Copyright © 2020 Cristhian Bolaños. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class FirebaseUtilities {
    
    var controller: UIViewController?
    
    init(controller: UIViewController?) {
        self.controller = controller
    }
    
    static func getName() -> String {
        
        return Auth.auth().currentUser?.displayName ?? ""
    }
    
    static func getPhotoUrl() -> String{
        let userPhotoURL = Auth.auth().currentUser?.photoURL
        var userPhoto: String = ""
        if userPhotoURL != nil {
            userPhoto = userPhotoURL!.absoluteString
            print("User photo URL successfully recovered: %@", userPhoto)
        }
        return userPhoto
 
    }
    
    static func saveCocktail(cocktail: Cocktail, email: String){
        let db = Firestore.firestore()
        
        var dicCocktail = Dictionary<String,Any>()
        dicCocktail["author"] = email
        dicCocktail["date"] = Utilities.getDate()
        dicCocktail["description"] = cocktail.description
        dicCocktail["image_url"] = cocktail.imageUrl
        dicCocktail["title"] = cocktail.title
        dicCocktail["tutorial"] = cocktail.tutorial
        for (index, ingredient) in cocktail.ingredients.enumerated(){
            dicCocktail["ingredient_"+String(index+1)] = ingredient
        }
        
        var ref: DocumentReference? = nil
        ref = db.collection("cocktails").addDocument(data: dicCocktail) { err in
            if let err = err {
                print("Error adding cocktail: \(err)")
            } else {
                print("Document added with ID: \(ref!.documentID)")
            }
        }
    }
    
    static func getCocktails(from email: String) -> [Cocktail]? {
        var cocktails: [Cocktail]? = nil
        let db = Firestore.firestore()
        db.collection("cocktails").whereField("author", isEqualTo: email).getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    //var cocktail : Cocktail = Cocktail(id: document.documentID, title: document.data()., description: <#T##String#>, tutorial: <#T##String#>, ingredients: <#T##[String]#>, creatorsEmail: <#T##String#>, favourite: <#T##Bool#>, prepared: <#T##Bool#>, image: <#T##UIImage?#>, imageUrl: <#T##String#>)
                    //cocktails?.append(cocktail)
                    print("\(document.documentID) => \(document.data())")
                }
            }
        }
        return nil
    }
    
}
