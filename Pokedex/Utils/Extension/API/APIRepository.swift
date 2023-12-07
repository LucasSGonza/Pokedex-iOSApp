//
//  APIHelper.swift
//  Pokedex
//
//  Created by Squad Apps on 16/11/23.
//

import UIKit
import Alamofire

class APIRepository: HelperControler {
    
    //https://www.logilax.com/swift-escaping-closure/#:~:text=In%20Swift%2C%20a%20closure%20marked,the%20surrounding%20function%20is%20gone”.
    func getData(completion: @escaping (Pokemon?, Bool) -> Void) {

        //tirei o acabou == 151 pq sempre dava true
        
        for id in 1...151 {
            let url = "https://pokeapi.co/api/v2/pokemon/\(id)"
//            let url = "https://pokeapi.co/api/v2/pokemon/q"
            Alamofire.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil)
                .responseJSON { response in
                    switch response.result {
                        case .success:
                            if let data = response.data {
                                do {
                                    guard let pokemon: Pokemon = try? JSONDecoder().decode(Pokemon.self, from: data) else { return }
                                    completion(pokemon, true)
                                }
                            }
                            break
                        case .failure:
                            completion(nil,false)
                            break
                    }
                }
        }
    }
    
    func getTextFromASpecificPokemon(pokemon: Pokemon, completion: @escaping (String) -> Void) {
        let url = pokemon.species.url
        Alamofire.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil)
            .responseData{ response in
                switch response.result {
                    case .success:
                        if let data = response.data {
                            do {
                                guard let pokemon: PokeText = try? JSONDecoder().decode(PokeText.self, from: data), let pokeText = pokemon.flavor_text_entries.first(where: { $0.language.name == "en" }) else { return }
                                completion(pokeText.flavor_text)
                            }
                        }
                    case .failure:
                        break;
                }
            }
    }
    
}
