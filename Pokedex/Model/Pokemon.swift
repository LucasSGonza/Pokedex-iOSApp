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
    var types: [Item]

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
    
    struct Item: Decodable {
        var type: PokeType
    }
    
    struct PokeType: Decodable {
        var name: String
    }

}
