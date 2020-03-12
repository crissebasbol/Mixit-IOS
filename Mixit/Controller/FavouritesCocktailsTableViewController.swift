//
//  FavouritesCocktailsTableViewController.swift
//  Mixit
//
//  Created by Telematica on 3/8/20.
//  Copyright © 2020 Cristhian Bolaños. All rights reserved.
//

import UIKit

class FavouritesCocktailsTableViewController: UITableViewController {

    //CocktailsManager object to handle operations over the Cocktail collection
    var cocktailsManager: CocktailsManager = CocktailsManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        if let favourites = UserDefaultsUtilities.getFavourites() {
            cocktailsManager.cocktails = Cocktail.parseDictionaries(dictionaries: favourites)
        }
        // cocktailsManager.cocktails = cocktailsManager.loadCocktails()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        let selectedIndexPath = tableView.indexPathForSelectedRow
        if let cocktailViewController = segue.destination as? CocktailViewController {
            cocktailViewController.cocktail = cocktailsManager.getCocktail(at: selectedIndexPath!.row)
        }
    }
}
