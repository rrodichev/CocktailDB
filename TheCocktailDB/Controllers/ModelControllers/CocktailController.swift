//
//  CocktailController.swift
//  TheCocktailDB
//
//  Created by Rozalia Rodichev on 8/4/21.
//

import Foundation
import UIKit

class CocktailController {
    
    static func fetchCocktail(searchTerm: String, completion: @escaping (Result<Cocktail, CocktailError>) -> Void) {
        
        var urlComponents = URLComponents(string: "https://www.thecocktaildb.com/api/json/v1/1/search.php")!
        urlComponents.queryItems = [URLQueryItem(name: "s", value: searchTerm)]

        let url = urlComponents.url!
        print(url)
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            // error
            if let error = error {
                return completion(.failure(.thrownError(error)))
            }
            // response
            if let response = response as? HTTPURLResponse {
                if response.statusCode != 200 {
                    print("STATUS CODE: \(response.statusCode)")
                }
            }
            // valid data
            guard let data = data else {
                return completion(.failure(.noData))
            }
            // decode from data
            do {
                let topLevelObject = try JSONDecoder().decode(TopLevelObject.self, from: data)
                guard let cocktail = topLevelObject.drinks.first else {
                    return completion(.failure(.noData))
                }
                return completion(.success(cocktail))
            } catch {
                return completion(.failure(.unableToDecode))
            }
        }.resume()
    }
    
    static func fetchStrDrinkThumb(for cocktail: Cocktail, completion: @escaping (Result<UIImage, CocktailError>) -> Void) {
        
        guard let url = cocktail.strDrinkThumb else {
            return completion(.failure(.invalidURL))
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                return completion(.failure(.thrownError(error)))
            }
            if let response = response as? HTTPURLResponse {
                if response.statusCode != 200 {
                    print("STATUS CODE: \(response.statusCode)")
                }
            }
            guard let data = data else {
                return completion(.failure(.noData))
            }
            guard let thumb = UIImage(data: data) else {
                return completion(.failure(.unableToDecode))
            }
            return completion(.success(thumb))
        }.resume()
    }

}//end of class
