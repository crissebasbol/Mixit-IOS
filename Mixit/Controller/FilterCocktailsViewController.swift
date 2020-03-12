//
//  FilterCocktailsViewController.swift
//  Mixit
//
//  Created by Telematica on 3/11/20.
//  Copyright © 2020 Cristhian Bolaños. All rights reserved.
//

import UIKit

class FilterCocktailsViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
        
    @IBOutlet weak var category: UIPickerView!
    @IBOutlet weak var alcohol: UIPickerView!
    @IBOutlet weak var ingredient: UIPickerView!
    @IBOutlet weak var glass: UIPickerView!
    
    var categoryData = [""]
    var alcoholData = [""]
    var ingredientData = [""]
    var glassData = [""]
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView.tag {
        case 1:
            return categoryData.count
        case 2:
            return categoryData.count
        case 3:
            return categoryData.count
        case 4:
            return categoryData.count
        default:
            return 0
        }
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView.tag {
        case 1:
            return categoryData[row]
        case 2:
            return alcoholData[row]
        case 3:
            return ingredientData[row]
        case 4:
            return glassData[row]
        default:
            return ""
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        loadData()
        
        category.delegate = self
        alcohol.delegate = self
        ingredient.delegate = self
        glass.delegate = self
        
        category.dataSource = self
        alcohol.dataSource = self
        ingredient.dataSource = self
        glass.dataSource = self
    }
    
    func loadData () {
        if let path = Bundle.main.path(forResource: "queryParams", ofType: "json") {
            do {
                  let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                  let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                  if let jsonResult = jsonResult as? Dictionary<String, AnyObject> {
                    
                    self.categoryData = jsonResult["category"] as! [String]
                    self.alcoholData = jsonResult["alcohol"] as! [String]
                    self.ingredientData = jsonResult["ingredient"] as! [String]
                    self.glassData = jsonResult["glass"] as! [String]
                }
              } catch {
                   // handle error
              }
        }    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
