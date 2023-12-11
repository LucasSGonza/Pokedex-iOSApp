//
//  HelperController.swift
//  Pokedex
//
//  Created by Squad Apps on 23/11/23.
//

import Foundation
import UIKit

class HelperControler: UIViewController {
    
//    enum APIErrors {
//        case <#case#>
//    }
    
    var alertForLoading = UIAlertController(title: nil, message: "Please wait...", preferredStyle: .alert)
    var alertForError: UIAlertController = UIAlertController(title: "Error", message: "Failed to load data from API", preferredStyle: .alert)
    
    //MARK: loading screen
    func showLoadingAlert() {
        alertForLoading.view.tintColor = UIColor.black
        
        let loadingIndicator: UIActivityIndicatorView = UIActivityIndicatorView(frame: CGRect(x:10, y:5, width: 50, height:50)) as UIActivityIndicatorView
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = UIActivityIndicatorView.Style.medium
        loadingIndicator.startAnimating();

        alertForLoading.view.addSubview(loadingIndicator)
        self.present(alertForLoading, animated: true, completion: nil)
    }
    
    func dismissLoadinAlert() {
//        alertForLoading.dismiss(animated: true, completion: nil)
        self.dismiss(animated: true, completion: nil)
    }
    
    //completion: (() -> Void)? = nil
    func showErrorAlert(message: String?, completion: (() -> Void)? = nil) {
        self.alertForError.addAction(UIAlertAction(title: "Ok", style: .default, handler: { _ in completion?()}))
        if let message = message {
            self.alertForError.message = message
        }
        self.present(alertForError, animated: true, completion: nil)
    }
    
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
    
    func setupVisualForStats (stat: Int) -> String {
        switch true {
        case stat < 10:
            return "00\(stat)"
            
        case stat < 100:
            return "0\(stat)"
            
        case stat >= 100:
            return "\(stat)"
        
        default:
            return ""
        }
    }
    
    func setupBackgroundcolorBasedOnPokeType (pokemonType: String) -> UIColor {
        return UIColor(named: pokemonType) ?? UIColor(named: "defaultBackground") ?? UIColor.gray
    }
    
}
