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
//    private var sprites: String //photo
//    private var stats: [(String)]
    
    enum CodingStringKeys: String, CodingKey {
//the string values should match EXACTLY with the corresponding key in the JSON object
        case name = "name"
        case id = "id"
    }
    
}
