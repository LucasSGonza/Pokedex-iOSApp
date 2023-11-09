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
//    private var type: [String]
//    private var weight: String
//    private var height: String
//    private var moves: [String]
//    private var text: String
     var sprites: Sprites //photo
//    private var stats: [(String)]
    
    struct Sprites: Decodable {
        var front_default: String
    }
    
        func showInfos() -> String {
            return """
            ID: \(self.id)
            Name: \(self.name)
            PhotoURL: \(self.sprites.front_default)
            """
        }
    
//    struct Sprites: Decodable {
//        var other: Other
//    }
//
//    struct Other: Decodable {
//        var officialArtwork: OfficialArtWork
//    }
//
//    struct OfficialArtWork: Decodable {
//        var front_default: String
//    }
//
//    enum CodingStringKeys: String, CodingKey {
//        //the string values should match EXACTLY with the corresponding key in the JSON object
//        case officialArtwork = "official-artwork"
//    }
    
}
