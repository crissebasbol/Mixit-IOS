//
//  CocktailsTableViewController.swift
//  Mixit
//
//  Created by Telematica on 3/4/20.
//  Copyright © 2020 Cristhian Bolaños. All rights reserved.
//

import UIKit

class MyCocktailsTableViewController: UITableViewController {
    
    //CocktailsManager object to handle operations over the Cocktail collection
    var cocktailsManager: CocktailsManager = CocktailsManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        FirebaseUtilities.getCocktails(from: UserDefaultsUtilities.getEmail() ?? "")
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return cocktailsManager.cocktailCount
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cocktailCell", for: indexPath)
        
        let cocktail = cocktailsManager.getCocktail(at: indexPath.row)

        cell.textLabel?.text = cocktail.title
        cell.detailTextLabel?.text = cocktail.description
        cell.imageView?.image = cocktail.image

        return cell
    }
    
    //Prepare the segue before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        if let createCocktailViewController = segue.destination as? CreateCocktailViewController{
            createCocktailViewController.delegate = self
        } else if
            let selectedIndexPath = tableView.indexPathForSelectedRow,
            let cocktailViewController = segue.destination as? CocktailViewController {
            cocktailViewController.cocktail = cocktailsManager.getCocktail(at: selectedIndexPath.row)
            cocktailViewController.delegate = self
        }
    }

}

//Defines an extension implement the CocktailViewControllerDelegateProtocol
extension MyCocktailsTableViewController: CocktailViewControllerDelegate{
    //Gives an implementation to saveCocktail method using addCocktail CocktailsManager method when the navigation from CocktailViewController is complete it loads the Cocktail data from previous scene in the Books Manager and refresh the table information
    func saveCocktail(_ cocktail: Cocktail){
        FirebaseUtilities.saveCocktail(cocktail: cocktail, email: UserDefaultsUtilities.getEmail() ?? "")
        cocktailsManager.addCocktail(cocktail: cocktail)
        tableView.reloadData()
    }
}
