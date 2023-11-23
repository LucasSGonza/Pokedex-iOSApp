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
    
}
