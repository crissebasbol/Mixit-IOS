//
//  SignInViewController.swift
//  Mixit
//
//  Created by Telematica on 3/11/20.
//  Copyright © 2020 Cristhian Bolaños. All rights reserved.
//

import UIKit
import Firebase

class SignInViewController: UIViewController {
    
    @IBOutlet weak var emailField: UITextField!
    
    @IBOutlet weak var passwordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func validateFields() -> String?{
        var error: String? = nil
        error = Utilities.checkEmptyField(text: emailField.text, nameField: "Email")
        error = error ?? Utilities.checkEmptyField(text: passwordField.text, nameField: "Password")
        return error
    }
    
    func transitionHome() {
        Utilities.transition(wich: Constants.Storyboard.TAB_BAR_STORYBOARD, where: Constants.Controller.TAB_BAR_VIEW_CONTROLLER, from: self, fullScreen: true, bundle: nil)
    }
    
    
    @IBAction func touchForgotPassword(_ sender: Any) {
        let error = Utilities.checkEmptyField(text: emailField.text, nameField: "Email")
        if error != nil {
            Utilities.showAlert(title: "Error in email field", message: "Please input an email for password reset", controller: self)
        }else{
            let email = emailField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            Auth.auth().sendPasswordReset(withEmail: email) { (error) in
                if error != nil {
                    Utilities.showAlert(title: "Error", message: "An error happened, please verify your connection to internet or try it later", controller: self)
                    print("Error sending password reset: ")
                    print(error!.localizedDescription)
                }else{
                    Utilities.showAlert(title: "Email sending", message: "The email for password reset has been sent, please verify you email", controller: self)
                }
            }
        }
    }
    
    @IBAction func touchSignIn(_ sender: Any) {
        //Validate text fields
        let error = validateFields()
        if error != nil {
            //There's something wrong with the fields, show error message
            Utilities.showAlert(title: "Error in field(s)", message: error!, controller: self)
        }else{
            //Create cleaned versions of the data
            let email = emailField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = passwordField.text!
            
            //Siging in the user
            Auth.auth().signIn(withEmail: email, password: password){ (result, error) in
                
                if error != nil {
                    //Couldn't sign in
                    Utilities.showAlert(title: "Authentification error", message: "An error ocurred while you trying to log in, check your email or password", controller: self)
                    print("Error Sign in: ")
                    print(error!.localizedDescription)
                }else{
                    //Sign in successfully
                     DispatchQueue.global(qos: .background).async {
                       let name = FirebaseUtilities.getName()
                       let photoUrl = FirebaseUtilities.getPhotoUrl()
                       DispatchQueue.main.async {   UserDefaultsUtilities.saveUser(name: name, email: email, photoUrl: photoUrl)
                        self.transitionHome()
                        }
                    }
                }
                
            }
        }
    
    }
    
    @IBAction func touchBack(_ sender: Any) {
        Utilities.dismiss(self)
    }
    
}
