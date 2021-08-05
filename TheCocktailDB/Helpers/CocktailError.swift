//
//  CocktailError.swift
//  TheCocktailDB
//
//  Created by Rozalia Rodichev on 8/4/21.
//

import Foundation

enum CocktailError: LocalizedError {
    case invalidURL
    case thrownError(Error)
    case noData
    case unableToDecode
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Unable to reach the server."
        case .thrownError(let error):
            return error.localizedDescription
        case .noData:
            return "The server responded with NO DATA."
        case .unableToDecode:
            return "Unable to turn data into the image."
        }
    }
}//end of enum

