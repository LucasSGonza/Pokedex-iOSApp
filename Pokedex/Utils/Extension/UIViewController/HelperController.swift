//
//  HelperController.swift
//  Pokedex
//
//  Created by Squad Apps on 23/11/23.
//

import Foundation
import UIKit

class HelperControler: UIViewController {
    
    var alertForInformation = UIAlertController(title: nil, message: nil, preferredStyle: .alert)
    var alertForLoading = UIAlertController(title: nil, message: "Please wait...", preferredStyle: .alert)
    var alertForError = UIAlertController(title: "Error", message: "Failed to load data from API", preferredStyle: .alert)
    
    var refreshControl = UIRefreshControl()
    
    //MARK:Alert for Infos
    func setupAlertForInformation(title: String?, message: String, completion: (() -> Void)? = nil) {
        alertForInformation.title = title ?? nil
        alertForInformation.message = message
        alertForInformation.addAction(UIAlertAction(title: "Ok", style: .default, handler: {_ in completion?()}))
    }
    
    func showAlertForInformation() {
        self.present(alertForInformation, animated: true, completion: nil)
    }
    
    //MARK: func for the setup Alert's
    func setupAlerts() {
        setupLoadingAlert()
        setupErrorAlert()
    }
    
    //MARK: Loading Alert
    
    func setupLoadingAlert(completion: (() -> Void)? = nil) {
        alertForLoading.view.tintColor = UIColor.black
        
        let loadingIndicator: UIActivityIndicatorView = UIActivityIndicatorView(frame: CGRect(x:10, y:5, width: 50, height:50)) as UIActivityIndicatorView
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = UIActivityIndicatorView.Style.medium
        loadingIndicator.startAnimating();

        alertForLoading.view.addSubview(loadingIndicator)
    }
    
    func showLoadingAlert() {
        self.present(alertForLoading, animated: true, completion: nil)
    }
    
    func dismissLoadinAlert() {
        self.dismiss(animated: true, completion: nil)
    }
    
    //MARK: Error alert
    func setupErrorAlert(completion: (() -> Void)? = nil){
        alertForError.addAction(UIAlertAction(title: "Ok", style: .default, handler: { _ in completion?()}))
    }
    
    func showErrorAlert(message: String?) {
        if let message = message {
            self.alertForError.message = message
        }
        self.present(alertForError, animated: true, completion: nil)
    }
    
    //MARK: func to setup visual
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
    
    func setupBackgroundColorBasedOnPokeType (pokemonType: String) -> UIColor {
        return UIColor(named: pokemonType) ?? UIColor(named: "defaultBackground") ?? UIColor.gray
    }
    
}
