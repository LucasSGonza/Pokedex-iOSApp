//
//  APIController.swift
//  Pokedex
//
//  Created by Squad Apps on 03/11/23.
//

import UIKit
import Alamofire

//https://www.avanderlee.com/swift/json-parsing-decoding/
//https://www.youtube.com/watch?v=eCfbrEeNkvo
//https://medium.com/swlh/how-to-work-with-json-in-swift-83cd93a837e

class APIController {
    
    private var pokemonArray: [Pokemon] = []
    
    //methods
    func getData() -> [Pokemon] {
        //id++ after each loop, until id = 151
//        for id in 1...3 {
//            let url = "https://pokeapi.co/api/v2/pokemon/\(id)"
//            Alamofire.request(url).responseJSON { response in
//                guard let jsonData = response.data else { return }
//                self.pokemon = try! JSONDecoder().decode(Pokemon.self, from: jsonData)
//                guard let pokemon = self.pokemon else { return }
//                self.pokemonArray.append(pokemon)
//            }
//        }
        let url = "https://pokeapi.co/api/v2/pokemon/1"
        Alamofire.request(url).responseJSON { response in
            //response.value é meu JSON, mas ele n é do tipo 'Data'
            if response.value != nil {
                guard let jsonData = response.data else { return }
                let pokemon: Pokemon = try! JSONDecoder().decode(Pokemon.self, from: jsonData)
                self.pokemonArray.append(pokemon)
            }
        }
        return self.pokemonArray
    }
    
//    func setData() {
//        let url = "https://pokeapi.co/api/v2/pokemon/1"
//        Alamofire.request(url).responseJSON { response in
//            guard let jsonData = response.data else { return }
//            self.pokemon = try! JSONDecoder().decode(Pokemon.self, from: jsonData)
//            print(self.pokemon.name)
//        }
//    }
    
}
