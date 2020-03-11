//
//  Alert.swift
//  Mixit
//
//  Created by Telematica on 3/10/20.
//  Copyright © 2020 Cristhian Bolaños. All rights reserved.
//

import UIKit

class Alert{
    func showAlert(title: String, message: String){
        let ac = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let alert = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler:  { (action) in
            ac.dismiss(animated: true, completion: nil)
        })
        ac.addAction(alert)
        ac.present(ac, animated: true, completion: nil)
    }
}
