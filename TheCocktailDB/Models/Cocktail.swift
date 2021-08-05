//
//  Cocktail.swift
//  TheCocktailDB
//
//  Created by Rozalia Rodichev on 8/4/21.
//

import Foundation

struct Cocktail: Decodable {
    let strDrink: String
    let strAlcoholic: String
    let strInstructions: String
    let strDrinkThumb: URL?
}//end of struck

struct TopLevelObject: Decodable {
    let drinks: [Cocktail]
}//end of struck
