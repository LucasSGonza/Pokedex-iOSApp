//
//  Pokemon.swift
//  Pokedex
//
//  Created by Squad Apps on 03/11/23.
//

import UIKit

class Pokemon: Decodable {

    //atributes
    var id: Int
    var name: String
    var weight: Double
    var height: Double
    var sprites: Sprites //photo
    var types: [ItemType]
    var abilities: [ItemAbility]
    var stats: [Stats]
    var species: Species
    var pokemonText: String?

    //Structs for sprites (pokemon photo)
    struct Sprites: Decodable {
        var other: Other
    }
    
    struct Other: Decodable {
        var home: Home
        var officialArtwork: OfficialArtwork
        
        enum CodingKeys: String, CodingKey {
            //the string values should match EXACTLY with the corresponding key in the JSON object
            case home = "home"
            case officialArtwork = "official-artwork"
        }
        
    }
    
    struct Home: Decodable {
        var front_default: String
    }
    
    struct OfficialArtwork: Decodable {
        var front_default: String
    }
    //-----------
    
    //MARK: Structs for types
    struct ItemType: Decodable {
        var type: PokeType
    }
    
    struct PokeType: Decodable {
        var name: String
    }
    //-----------
    
    //MARK: Struct for abilities
    struct ItemAbility: Decodable {
        var ability: Ability
    }
    
    struct Ability: Decodable {
        var name: String
    }
    //-----------
    
    //MARK: Struct for stats
    struct Stats: Decodable {
        var base_stat: Int
        var stat: Stat
    }
    struct Stat: Decodable {
        var name: String
    }
    //-----------
    
    //MARK: Struct for pokemon-species URL
    //to get the URL for the pokemon speeches
    struct Species: Decodable {
        var url: String
    }
    //-----------
}
