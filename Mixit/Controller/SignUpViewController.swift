//
//  SignUpViewController.swift
//  Mixit
//
//  Created by Telematica on 3/10/20.
//  Copyright © 2020 Cristhian Bolaños. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase
import FirebaseFirestore

class SignUpViewController: UIViewController {
    
    var db: Firestore!
    
    @IBOutlet weak var nameField: UITextField!
    
    @IBOutlet weak var emailField: UITextField!
    
    @IBOutlet weak var passwordField: UITextField!
    
    @IBOutlet weak var repeatPasswordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //[START setup]
        let settings = FirestoreSettings()
        
        Firestore.firestore().settings = settings
        
        //[END setup]
        db = Firestore.firestore()
    }
    
    //Check the field and validate that the data is correct if everyhing is correct, this method returns nil, otherwise, it returns the error message
    func validateFields() -> String? {
        var error: String? = nil
        //Check that all the field are filler in
        error = Utilities.checkEmptyField(text: nameField.text, nameField: "Name")
        error = error ?? Utilities.checkEmptyField(text: emailField.text, nameField: "Email")
        error = error ?? Utilities.checkEmptyField(text: passwordField.text, nameField: "Password")
        error = error ?? Utilities.checkEmptyField(text: repeatPasswordField.text, nameField: "Confirm Password")
        //check the passwords
        if error == nil {
            if Utilities.compareStrings(string1: passwordField.text!, string2: repeatPasswordField.text!){
                error = nil
            } else{
                error = "The passwords are different"
            }
        }
        
        return error
        
    }
    
    @IBAction func touchSignUp(_ sender: Any) {
        //validate the fields
        let error = validateFields()
        if error != nil {
            //There's something wrong with the fields, show error message
            Utilities.showAlert(title: "Error in field(s)", message: error!, controller: self)
        }else{
            //Create cleaned versions of the data
            let name = nameField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let email = emailField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            //Create the user
            Auth.auth().createUser(withEmail: email, password: passwordField.text!) { (result, errorFirebaseAuth) in
                
                //Check for error
                if errorFirebaseAuth != nil {
                    //There was an error creating the user
                    Utilities.showAlert(title: "Creating user", message: "Error creating user, please verify your connection to internet", controller: self)
                    print("Error creating user firebase: "+errorFirebaseAuth!.localizedDescription)
                    
                }else{
                    //User was created successfully
                    print("User created successfully")
                   //transition to home
                    self.transitionToHome()
                }
                
            }
        }
        
    }
    
    func transitionToHome(){
        Utilities.transition(wich: Constants.Storyboard.tabBarStoryBoard, where: Constants.Controller.tabBarViewController, from: self, fullScreen: true, bundle: nil)
    }
    
    @IBAction func touchComeBack(_ sender: Any) {
        Utilities.dismiss(self)
    }
    
}
