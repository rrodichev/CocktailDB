//
//  CocktailViewController.swift
//  TheCocktailDB
//
//  Created by Rozalia Rodichev on 8/4/21.
//

import UIKit

class CocktailViewController: UIViewController {

    // MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        drinkSearchBar.delegate = self
    }
    
    // MARK: - Outlets
    
    @IBOutlet weak var drinkSearchBar: UISearchBar!
    @IBOutlet weak var drinkNameLabel: UILabel!
    @IBOutlet weak var drinkCategoryLabel: UILabel!
    @IBOutlet weak var drinkInstructions: UILabel!
    @IBOutlet weak var drinkImage: UIImageView!
    
    
    // MARK: - Helper methods
    
    func fetchThumbAndUpdateViews(for cocktail: Cocktail) {
        CocktailController.fetchStrDrinkThumb(for: cocktail) { (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let thumb):
                    self.drinkNameLabel.text = cocktail.strDrink
                    self.drinkCategoryLabel.text = cocktail.strAlcoholic
                    self.drinkInstructions.text = cocktail.strInstructions
                    self.drinkImage.image = thumb
                case .failure(let error):
                    self.presentErrorToUser(localizedError: error)
                }
            }
        }
    }
}//end of class

//extension
extension CocktailViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = searchBar.text, !searchTerm.isEmpty else {
            return
        }
        CocktailController.fetchCocktail(searchTerm: searchTerm.lowercased()) { (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let cocktail):
                    self.fetchThumbAndUpdateViews(for: cocktail)
                case .failure(let error):
                    self.presentErrorToUser(localizedError: error)
                }
            }
        }
    }
}
