//
//  UIView.swift
//  Pokedex
//
//  Created by Squad Apps on 28/11/23.
//

import Foundation
import UIKit

extension UIView {
    
    func setupBackgroundColorBasedOnType(pokemonType: String) {
            
        switch pokemonType {
            
        case "bug":
            self.backgroundColor = UIColor(named: "bug")
            break
            
        case "dark":
            self.backgroundColor = UIColor(named: "dark")
            break
            
        case "dragon":
            self.backgroundColor = UIColor(named: "dragon")
            break
            
        case "electric":
            self.backgroundColor = UIColor(named: "electric")
            break
            
        case "fairy":
            self.backgroundColor = UIColor(named: "fairy")
            break
            
        case "fighting":
            self.backgroundColor = UIColor(named: "fighting")
            break
            
        case "fire":
            self.backgroundColor = UIColor(named: "fire")
            break
            
        case "flying":
            self.backgroundColor = UIColor(named: "flying")
            break
            
        case "ghost":
            self.backgroundColor = UIColor(named: "ghost")
            break
            
        case "normal":
            self.backgroundColor = UIColor(named: "normal")
            break
            
        case "grass":
            self.backgroundColor = UIColor(named: "grass")
            break
            
        case "ground":
            self.backgroundColor = UIColor(named: "ground")
            break
            
        case "ice":
            self.backgroundColor = UIColor(named: "ice")
            break
            
        case "poison":
            self.backgroundColor = UIColor(named: "poison")
            break
            
        case "psychic":
            self.backgroundColor = UIColor(named: "psychic")
            break
            
        case "rock":
            self.backgroundColor = UIColor(named: "rock")
            break
            
        case "steel":
            self.backgroundColor = UIColor(named: "steel")
            break
            
        case "water":
            self.backgroundColor = UIColor(named: "water")
            break
            
        default:
            self.backgroundColor = UIColor(named: "defaultBackground")
            break
        }
    }

}
