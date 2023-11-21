//
//  APIHelper.swift
//  Pokedex
//
//  Created by Squad Apps on 16/11/23.
//

import UIKit
import Alamofire

class APIRepository {
    
//    private var pokemonArrayDB: [Pokemon] = []
    
    func getData(completion: @escaping (Pokemon) -> Void) {
        
        for id in 1...151 {
            let url = "https://pokeapi.co/api/v2/pokemon/\(id)"
            Alamofire.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil)
                .responseJSON { response in
                    switch response.result {
                        case .success:
                            if let data = response.data {
                                do {
                                    guard let pokemon: Pokemon = try? JSONDecoder().decode(Pokemon.self, from: data) else { return }
                                    completion(pokemon)
                                }
                            }
                        case .failure:
                            break;
                    }
                }
        }
    }
    
}
