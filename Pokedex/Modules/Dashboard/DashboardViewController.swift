//
//  ViewController.swift
//  Pokedex
//
//  Created by Squad Apps on 20/10/23.
//

import UIKit
import Alamofire

class DashboardViewController: HelperControler {
    
    //MARK: Main itens of the screen
    @IBOutlet weak var filterButton: UIButton!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var filterModal: UIView!
    @IBOutlet weak var viewFilterInsideModal: UIView!
    @IBOutlet weak var numberOption: UIButton!
    @IBOutlet weak var nameOption: UIButton!
    
    //booleans for the modal interaction
    private var isFilterSelected: Bool = false
    
    //attributes used in the project
    private var pokemonArrayDB: [Pokemon] = []
    private var customizedPokemonArray: [Pokemon] = []
    private var apiRepository = APIRepository()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        startAllSetupFunctions()
        
        getDataFromAPI { (numReqs, flag) in
            if numReqs == 151 {
                if flag {
                    self.collectionView.reloadData()
                    self.setupCustomArrayToDefault()
                    self.dismissLoadinAlert(flag: true)
                } else {
                    self.dismissLoadinAlert(flag: true)
                }
            }
        }

    }
    
    //MARK: Main function to get data from the PokeAPI
    private func getDataFromAPI(completion: @escaping (Int, Bool) -> Void) {
        showLoadingAlert()
        
        apiRepository.getData(
            completion: { (pokemon, flag, numReqs) in
            guard let numReqs = numReqs else { return }
            if let pokemon = pokemon {
                self.apiRepository.getTextFromASpecificPokemon(pokemon: pokemon, completion: { text in
                    pokemon.pokemonText = text.replacingOccurrences(of: "\n", with: " ")
                })
                self.pokemonArrayDB.append(pokemon)
                self.pokemonArrayDB = self.pokemonArrayDB.sorted{ $0.id < $1.id }
    //            print(self.pokemonArrayDB.count)
    //            completion(self.pokemonArrayDB.count, flag)
                completion(numReqs, flag)
            } else {
                completion(numReqs, flag)
            }
        })
    }
    
    //MARK: my setup functions
    private func startAllSetupFunctions() {
        setupVisualStructure()
        setupCollectionView()
        setupSearchBar()
        setupActionForOptionBtts()
//        showLoadingAlert()
    }
    
    private func setupVisualStructure() {
        filterButton.backgroundColor = UIColor.white
        filterButton.layer.cornerRadius = 16
        filterModal.layer.cornerRadius = 12
        viewFilterInsideModal.layer.cornerRadius = 8
        
//        collectionView.layer.shadowRadius = 2
//        collectionView.layer.shadowColor = UIColor.black.cgColor
//        collectionView.layer.shadowOpacity = 0.80
//        collectionView.layer.shadowOffset = CGSize(width: 0, height: 1)
    }
    
    private func setupCollectionView() {
        //visual
        collectionView.backgroundColor = UIColor.white
        collectionView.layer.cornerRadius = 16
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "CollectionViewPokeCell", bundle: nil), forCellWithReuseIdentifier: "PokeCell")
    }
    
    private func setupSearchBar() {
        //visual
        searchBar.searchTextField.backgroundColor = UIColor.white
        searchBar.searchTextField.leftView?.tintColor = UIColor(named: "pokedex-red")
        searchBar.tintColor = UIColor.black
        searchBar.searchTextField.textColor = UIColor.black
        
        searchBar.delegate = self
    }
    
    private func setupCustomArrayToDefault() {
        customizedPokemonArray.removeAll()
        customizedPokemonArray.append(contentsOf: pokemonArrayDB)
    }
    
    //MARK: filter Modal
    @IBAction func showFilterModal(_ sender: Any) {
        UIView.animate(
            withDuration: 0.3,
            animations: self.filterModal.layoutIfNeeded,
            completion: { _ in
                self.filterModal.isHidden = (self.filterModal.isHidden) ? false : true
            }
        )
    }
    
    private func setupActionForOptionBtts() {
//        numberOption.addAction(optionSelected(), for: .touchUpInside)
        numberOption.addTarget(self, action: #selector(optionSelected), for: .touchUpInside)
        nameOption.addTarget(self, action: #selector(optionSelected), for: .touchUpInside)
    }
    
    @objc private func optionSelected(btt: UIButton) {
        guard let optionImage = btt.backgroundImage(for: .normal) else { return }
        if optionImage == UIImage(named: "selectedBtt") {
            btt.setBackgroundImage(UIImage(named: "unselectedBtt"), for: .normal)
            isFilterSelected = false
        } else if !isFilterSelected {
            btt.setBackgroundImage(UIImage(named: "selectedBtt"), for: .normal)
            isFilterSelected = true
        }
    }
    
}

//https://www.youtube.com/watch?v=TQOhsyWUhwg
//https://stackoverflow.com/questions/13970950/uicollectionview-spacing-margins

//MARK: CollectionView
extension DashboardViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return customizedPokemonArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PokeCell", for: indexPath) as! CollectionViewCellPokeCell
        let pokemon = customizedPokemonArray[indexPath.row]
        cell.bind(pokemon: pokemon)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let pokeDetailed = UIStoryboard(name: "PokeDetailed", bundle: nil).instantiateViewController(withIdentifier: "PokeDetailed") as! PokeDetailedViewController
        let pokemon = customizedPokemonArray[indexPath.row]
        print("Clicou em: \(pokemon.name) (dashboard)")
        pokeDetailed.initView(pokemonID: pokemon.id, pokemonArray: self.pokemonArrayDB)
        self.navigationController?.pushViewController(pokeDetailed, animated: true)
    }
    
}

extension DashboardViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let newWidth = (collectionView.frame.width - 72) / 3.0
        return CGSize(width: newWidth, height: 96)
    }
    
}

//MARK: SearchBar
extension DashboardViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        setupCustomArrayToDefault()
        
        if !searchText.isEmpty {
            customizedPokemonArray = customizedPokemonArray.filter {
                (($0.name.lowercased().contains(searchText.lowercased())) ||
                    ($0.id.description.contains(searchText)))
            }
        }
        collectionView.reloadData()
    }
    
}
