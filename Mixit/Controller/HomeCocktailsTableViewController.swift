//
//  HomeCocktailsTableViewController.swift
//  Mixit
//
//  Created by Telematica on 3/8/20.
//  Copyright © 2020 Cristhian Bolaños. All rights reserved.
//

import UIKit

class HomeCocktailsTableViewController: UITableViewController, UISearchBarDelegate, UIPopoverPresentationControllerDelegate {
    
    //CocktailsManager object to handle operations over the Cocktail collection
    var cocktailsManager: CocktailsManager = CocktailsManager()
    var cocktailsService: CocktailsAPIService = CocktailsAPIService()

    let searchController = UISearchController(searchResultsController: nil)
    var firstSet = [Cocktail]()
    
    @IBAction func filter(_ sender: Any) {
        let filterSegue = storyboard?.instantiateViewController(withIdentifier: "filterPopOver") as! FilterCocktailsViewController
        filterSegue.preferredContentSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height*0.3)
        navigationController?.modalPresentationStyle = UIModalPresentationStyle.popover
        
        let popOver = navigationController?.popoverPresentationController
        
        popOver?.delegate = self
        popOver?.barButtonItem = sender as? UIBarButtonItem
        
        filterSegue.delegate = self
        
        self.present(filterSegue, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.searchController = searchController
        searchController.searchBar.delegate = self
        cocktailsService.byFirstLetter() {
            (cocktails, error) in
            
            if error != nil {
                
            } else if let cocktails = cocktails {
                for cocktail in cocktails {
                    if cocktail.imageUpdated {
                        self.cocktailsManager.cocktails.append(cocktail)
                    }
                }
            }
            self.tableView.reloadData()
        }
        firstSet = self.cocktailsManager.cocktails
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.cocktailsManager.cocktails.removeAll()
        cocktailsService.search(search: searchText) {
            (cocktails, error) in
            if error != nil {
                
            } else if let cocktails = cocktails {
                for cocktail in cocktails {
                    if cocktail.imageUpdated {
                        self.cocktailsManager.cocktails.append(cocktail)
                    }
                }
                
            }
            self.tableView.reloadData()
        }


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
        if cocktailsManager.cocktailCount > indexPath.row {
            let cocktail = cocktailsManager.getCocktail(at: indexPath.row)

            cell.textLabel?.text = cocktail.title
            cell.detailTextLabel?.text = cocktail.description
            cell.imageView?.image = cocktail.image
            
        }

        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        let selectedIndexPath = tableView.indexPathForSelectedRow
        if let cocktailViewController = segue.destination as? CocktailViewController {
            cocktailViewController.cocktail = cocktailsManager.getCocktail(at: selectedIndexPath!.row)
        }
    }
}

extension HomeCocktailsTableViewController: CocktailViewControllerDelegate{
    func saveCocktail(_ cocktail: Cocktail) {
    }
    
    func updateCocktails(_ queryParams: [String : String]) {
        self.cocktailsManager.cocktails.removeAll()
        print("WhatsApp monkey")
        cocktailsService.filter(ingredient: queryParams["ingredient"], alcoholic: queryParams["alcohol"], category: queryParams["category"], glass: queryParams["glass"]) {
            (cocktails, error) in
            if error != nil {
                
            } else if let cocktails = cocktails {
                for cocktail in cocktails {
                    if cocktail.imageUpdated {
                        self.cocktailsManager.cocktails.append(cocktail)
                    }
                }
                
            }
            self.tableView.reloadData()
            
        }
    }
}
