//
//  PokeText.swift
//  Pokedex
//
//  Created by Squad Apps on 30/11/23.
//

import Foundation
import UIKit

class PokeText: Decodable {
    var flavor_text_entries: [FlavorText]
    
    struct FlavorText: Decodable {
        var flavor_text: String
        var language: Language
    }
    
    struct Language: Decodable {
        var name: String
    }
    
}
