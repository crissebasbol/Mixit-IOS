//
//  ProfileViewController.swift
//  Mixit
//
//  Created by Telematica on 3/11/20.
//  Copyright © 2020 Cristhian Bolaños. All rights reserved.
//

import UIKit
import Firebase

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var profileImage: UIImageView!
    
    @IBOutlet weak var emailLabel: UILabel!
    
    @IBOutlet weak var nameField: UITextField!
    
    @IBOutlet weak var passwordField: UITextField!
    
    @IBOutlet weak var repeatPasswordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        nameField.text = UserDefaultsUtilities.getName()
        emailLabel.text = UserDefaultsUtilities.getEmail()
        DispatchQueue.global(qos: .background).async {
               do
                {
                    let photoString = UserDefaultsUtilities.getPhotoUrl()
                    
                    if photoString != nil{
                        let data = try Data.init(contentsOf: URL.init(string:photoString!)!)
                        DispatchQueue.main.async {
                            let image: UIImage? = UIImage(data: data)
                            if image != nil {
                                self.profileImage.image = image
                            }
                        }
                    }
                    
                }
               catch {
                      // error
                     }
        }
        
    }
    
    @IBAction func touchSave(_ sender: Any) {
        var change = false
        let error = Utilities.checkEmptyField(text: nameField.text, nameField: "Name")
        if error != nil{
            Utilities.showAlert(title: "Error field", message: error!, controller: self)
        }else{
            change = true
            let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
            changeRequest?.displayName = nameField.text!
            changeRequest?.commitChanges(completion: { (error) in
                if error == nil {
                    UserDefaultsUtilities.setName(self.nameField.text!)
                }else{
                    Utilities.showAlert(title: "Error", message: "Please try later", controller: self)
                }
            })
        }
        let password = passwordField.text
        let repeatPassword = repeatPasswordField.text
        let errorp = Utilities.checkEmptyField(text: password, nameField: "Password")
        if errorp == nil {
            change = false
            let same = Utilities.compareStrings(string1: password!, string2: repeatPassword ?? "")
            if !same {
                Utilities.showAlert(title: "Error passwords", message: "The passwords are not the same", controller: self)
            }else{
                change = true
                Auth.auth().currentUser?.updatePassword(to: password!, completion: { (error) in
                    if error == nil {
                        print("Password successfullly updated")
                    }else{
                        print("error %@", error!)
                    }
                })
            }
        }
        if change {
            Utilities.dismiss(self)
        }
    }
    
}
