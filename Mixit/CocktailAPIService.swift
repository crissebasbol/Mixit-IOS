import Foundation
import UIKit

protocol APIService {
    func get(with path: String,
                 completionHandler: @escaping ([Cocktail]?, Error?) -> Void)

    func cancel()
}

class CocktailsAPIService: NSObject, APIService, URLSessionDelegate {
    lazy var session: URLSession = {
        let configuration = URLSessionConfiguration.default
        return URLSession(configuration: configuration,
                          delegate: self, delegateQueue: OperationQueue.main)
    }()
    
    let cocktailAPIUrl = "https://www.thecocktaildb.com/api/json/v1/1/"
    
    func get(with url: String,
                 completionHandler: @escaping ([Cocktail]?, Error?) -> Void){

        

        let request = URLRequest(url: URL(string: url)!)

        let dataTask = session.dataTask(with: request) {
            (data, response, error) in

            if let error = error {
                completionHandler(nil, error)
            }
            
            guard let data = data else { return }

            self.parseJSON(data: data, completionHandler: completionHandler)
        }
        dataTask.resume()
        
    }
    
    private func parseJSON(data: Data,
                           completionHandler:
        @escaping ([Cocktail]?, Error?) -> Void) {
        
        do {
            var cocktails = [Cocktail]()
            if let dataAsJSON =
                
                try JSONSerialization.jsonObject(
                    with: data,
                    options: []) as? [String: Any],
                let drinks = dataAsJSON["drinks"] as? [Any] {
                    for drink in drinks {
                        var parsedCocktail: Cocktail?
                        if let cocktail = drink as? [String: Any] {
                            let id = cocktail["idDrink"] as? String ?? "id"
                            let title = cocktail["strDrink"] as? String ?? "title"
                            var description = ""
                            var tutorial = ""
                            var ingredients = [String]()
                            if (cocktail["strCategory"] != nil) {
                                description = Cocktail.parseDescription(cocktail: cocktail)
                                tutorial = (cocktail["strInstructions"] as? String)!
                                ingredients = Cocktail.parseIngredients(cocktail: cocktail)                            }
                            parsedCocktail = Cocktail(
                                id: id,
                                title:  title,
                                description: description,
                                tutorial: tutorial,
                                ingredients: ingredients,
                                creatorsEmail: "creators",
                                favourite: false,
                                prepared: false
                            )
                            
                            loadImage(cocktail: parsedCocktail!, thumbnailURL: cocktail["strDrinkThumb"] as! String, completionHandler: completionHandler)
                            
                            cocktails.append(parsedCocktail!)
                        }
                        completionHandler(cocktails, nil)
                }
            } else {
                completionHandler(nil, nil)
            }
            
        } catch let error as NSError {
            completionHandler(nil, error)
            return
        }
    }
    
    func cancel() {
    }
    
    func loadImage(cocktail: Cocktail, thumbnailURL: String, completionHandler: @escaping ([Cocktail]?, Error?) -> Void) {
        var cocktail = cocktail

        guard let url = URL(string: thumbnailURL) else {return}

        let task = session.downloadTask(with: url) { (tempURL, response, error) in
            if let tempURL = tempURL,
                let data = try? Data(contentsOf: tempURL),
                let image = UIImage(data: data) {
                cocktail.image = image
            }
            completionHandler([cocktail], error)
        }

        task.resume()
    }
    func random(completionHandler: @escaping ([Cocktail]?, Error?) -> Void) {
        self.get(with: cocktailAPIUrl + "random.php", completionHandler: completionHandler)
    }
    
    func byFirstLetter(completionHandler: @escaping ([Cocktail]?, Error?) -> Void) {
        let letters = "abcdefghijklmnopqrstuvwxyz"
        let randomLetter = String(letters.randomElement()!)
        
        var components = URLComponents(string: cocktailAPIUrl + "search.php")!
        
        components.queryItems = [
            URLQueryItem(name: "f", value: randomLetter)
        ]
        guard let url = components.string else {return}
    
        self.get(with: url, completionHandler: completionHandler)
    }
    
    func search(search: String, completionHandler: @escaping ([Cocktail]?, Error?) -> Void) {
        var components = URLComponents(string: cocktailAPIUrl + "search.php")!
        components.queryItems = [
            URLQueryItem(name: "s", value: search)
        ]
        guard let url = components.string else {return}
    
        self.get(with: url, completionHandler: completionHandler)
    }
    func lookUp(id: String, completionHandler: @escaping ([Cocktail]?, Error?) -> Void) {
        var components = URLComponents(string: cocktailAPIUrl + "lookup.php")!
        components.queryItems = [
            URLQueryItem(name: "i", value: id)
        ]
        guard let url = components.string else {return}

        self.get(with: url, completionHandler: completionHandler)
    }
    func filter(ingredient: String?, alcoholic: String?, category: String?, glass: String?, completionHandler: @escaping ([Cocktail]?, Error?) -> Void) {
        var components = URLComponents(string: cocktailAPIUrl + "filter.php")!
        var queryItems = [URLQueryItem]()
        ingredient != nil ? queryItems.append(URLQueryItem(name: "i", value: ingredient)) : print("Ingredient not present")
        alcoholic != nil ? queryItems.append(URLQueryItem(name: "a", value: alcoholic)) : print("Alcoholic not present")
        category != nil ? queryItems.append(URLQueryItem(name: "c", value: category)) : print("Category not present")
        glass != nil ? queryItems.append(URLQueryItem(name: "g", value: glass)) : print("Glass not present")
        components.queryItems = queryItems
        guard let url = components.string else {return}
        
        self.get(with: url, completionHandler: completionHandler)
    }
    
}
