//
//  ViewController.swift
//  Pokedex
//
//  Created by Squad Apps on 20/10/23.
//

import UIKit

class DashboardViewController: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var filterIcon: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        setupVisualStructure()
    }
    
    func setupVisualStructure() {
        filterIcon.backgroundColor = UIColor.white
        filterIcon.layer.cornerRadius = 16
    }


}

