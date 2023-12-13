//
//  APIHelper.swift
//  Pokedex
//
//  Created by Squad Apps on 16/11/23.
//

import UIKit
import Alamofire

class APIRepository: HelperControler {
    
    private var numReqs: Int = 0
    
    private func getNumReqs() -> Int {
        return self.numReqs
    }
    
    private func setNumReqs(numReqs: Int) {
        self.numReqs = numReqs
    }
    
    func getData(completion: @escaping (Pokemon?, Bool, String?) -> Void) {
        setNumReqs(numReqs: 0)
        //ele sempre fará as 151 requisições
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
                                    self.setNumReqs(numReqs: (self.getNumReqs() + 1))
                                    print("req: \(self.getNumReqs())")
                                    
                                    // se for o último pokemon, mandar junto a flag == true avisando isso
                                    if self.getNumReqs() == 151 {
                                        completion(pokemon, true, nil)
                                    } else {
                                        //contudo, caso a req não estar/chegar no final, irá mandar a flag false
                                        completion(pokemon, false, nil)
                                    }
                                }
                            }
                            break
                        case .failure:
                            guard let errorMessage = response.result.error?.localizedDescription else { return }
                            
                            self.setNumReqs(numReqs: (self.getNumReqs() + 1))
                            
                            if self.getNumReqs() == 151 {
                                print(errorMessage)
                                completion(nil, true, errorMessage)
                            } else {
                                completion(nil, false, errorMessage)
                            }
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
