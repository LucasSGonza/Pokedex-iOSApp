//
//  ViewController.swift
//  Pokedex
//
//  Created by Squad Apps on 20/10/23.
//

import UIKit

class DashboardViewController: UIViewController {
    
    //MARK: Initial
    @IBOutlet weak var filterButton: UIButton!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var collectionView: UICollectionView!
    private var pokemonArray: [Pokemon] = [] //chamar metodo para popular no didLoad
    private var apiController: APIController = APIController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        setupVisualStructure()
        setupCollectionView()
        self.pokemonArray = apiController.getData()
    }
    
    //MARK: setup functions
    func setupVisualStructure() {
        filterButton.backgroundColor = UIColor.white
        filterButton.layer.cornerRadius = 16
        collectionView.backgroundColor = UIColor.white
        collectionView.layer.cornerRadius = 16
        searchBar.searchTextField.backgroundColor = UIColor.white
        searchBar.searchTextField.leftView?.tintColor = UIColor(named: "pokedex-red")
        searchBar.tintColor = UIColor.black
        searchBar.searchTextField.textColor = UIColor.black
    }
    
    private func setupCollectionView() {
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.register(UINib(nibName: "CollectionViewCellPokeCell", bundle: nil), forCellWithReuseIdentifier: "PokeCell")
    }

}

//https://www.youtube.com/watch?v=TQOhsyWUhwg
//https://stackoverflow.com/questions/13970950/uicollectionview-spacing-margins

//MARK: CollectionView
extension DashboardViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pokemonArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PokeCell", for: indexPath) as! CollectionViewCellPokeCell
        let pokemon = pokemonArray[indexPath.row]
        cell.bind(pokemon: pokemon)
        return cell
    }

    
}

