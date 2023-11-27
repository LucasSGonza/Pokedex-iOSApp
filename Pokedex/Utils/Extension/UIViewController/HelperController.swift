//
//  HelperController.swift
//  Pokedex
//
//  Created by Squad Apps on 23/11/23.
//

import Foundation
import UIKit

class HelperControler: UIViewController {
    
    func setupVisualForId (id: Int) -> String {
        switch true {
        case id < 10:
            return "#00\(id)"
            
        case id < 100:
            return "#0\(id)"
            
        case id >= 100:
            return "#\(id)"
        
        default:
            return ""
        }
    }
    
    func setupBackgroundColorBasedOnType(pokemonType: String, view: UIView?, label: UILabel?) {
        
        guard let view = view, let label = label else { return }
        
        switch pokemonType {
        
        case "bug":
            view.backgroundColor = UIColor(named: "bug")
            label.backgroundColor = UIColor(named: "bug")
            break
            
        case "dark":
            view.backgroundColor = UIColor(named: "dark")
            label.backgroundColor = UIColor(named: "dark")
            break
            
        case "dragon":
            view.backgroundColor = UIColor(named: "dragon")
            label.backgroundColor = UIColor(named: "dragon")
            break
            
        case "electric":
            view.backgroundColor = UIColor(named: "electric")
            label.backgroundColor = UIColor(named: "electric")
            break
            
        case "fairy":
            view.backgroundColor = UIColor(named: "fairy")
            label.backgroundColor = UIColor(named: "fairy")
            break
            
        case "fighting":
            view.backgroundColor = UIColor(named: "fighting")
            label.backgroundColor = UIColor(named: "fighting")
            break
            
        case "fire":
            view.backgroundColor = UIColor(named: "fire")
            label.backgroundColor = UIColor(named: "fire")
            break
            
        case "flying":
            view.backgroundColor = UIColor(named: "flying")
            label.backgroundColor = UIColor(named: "flying")
            break
            
        case "ghost":
            view.backgroundColor = UIColor(named: "ghost")
            label.backgroundColor = UIColor(named: "ghost")
            break
            
        case "normal":
            view.backgroundColor = UIColor(named: "normal")
            label.backgroundColor = UIColor(named: "normal")
            break
            
        case "grass":
            view.backgroundColor = UIColor(named: "grass")
            label.backgroundColor = UIColor(named: "grass")
            break
            
        case "ground":
            view.backgroundColor = UIColor(named: "ground")
            label.backgroundColor = UIColor(named: "ground")
            break
            
        case "ice":
            view.backgroundColor = UIColor(named: "ice")
            label.backgroundColor = UIColor(named: "ice")
            break
            
        case "poison":
            view.backgroundColor = UIColor(named: "poison")
            label.backgroundColor = UIColor(named: "poison")
            break
            
        case "psychic":
            view.backgroundColor = UIColor(named: "psychic")
            label.backgroundColor = UIColor(named: "psychic")
            break
            
        case "rock":
            view.backgroundColor = UIColor(named: "rock")
            label.backgroundColor = UIColor(named: "rock")
            break
            
        case "steel":
            view.backgroundColor = UIColor(named: "steel")
            label.backgroundColor = UIColor(named: "steel")
            break
            
        case "water":
            view.backgroundColor = UIColor(named: "water")
            label.backgroundColor = UIColor(named: "water")
            break
            
        default:
            view.backgroundColor = UIColor(named: "defaultBackground")
            label.backgroundColor = UIColor(named: "defaultBackground")
            break
        }
    }
    
}
