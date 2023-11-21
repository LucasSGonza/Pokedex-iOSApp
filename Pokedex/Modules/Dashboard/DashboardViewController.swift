//
//  ViewController.swift
//  Pokedex
//
//  Created by Squad Apps on 20/10/23.
//

import UIKit
import Alamofire

class DashboardViewController: UIViewController {
    
    //MARK: Initial
    @IBOutlet weak var filterButton: UIButton!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var filterModal: UIView!
    @IBOutlet weak var viewFilterInsideModal: UIView!
    @IBOutlet weak var numberOption: UIButton!
    @IBOutlet weak var nameOption: UIButton!
    
    private var isFilterSelected: Bool = false
    private var pokemonArrayDB: [Pokemon] = [] //chamar metodo para popular no didLoad
    private var customizedPokemonArray: [Pokemon] = []
    private var apiRepository = APIRepository()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
//        getData()
        getDataFromAPI(completion: {
            self.collectionView.reloadData()
            self.setupCustomArrayToDefault()
        })
        setupVisualStructure()
        setupCollectionView()
        setupSearchBar()
        setupActionForOptionBtts()
    }
    
//    override func viewDidAppear(_ animated: Bool) {
//        setupPokeArrayToDefault()
//    }
    
    private func getDataFromAPI(completion: @escaping () -> Void) {
        apiRepository.getData(completion: { pokemon in
            self.pokemonArrayDB.append(pokemon)
            self.pokemonArrayDB = self.pokemonArrayDB.sorted{ $0.id < $1.id }
            completion()
        })
    }
    
    //MARK: setup functions
    private func setupVisualStructure() {
        filterButton.backgroundColor = UIColor.white
        filterButton.layer.cornerRadius = 16
        filterModal.layer.cornerRadius = 12
        viewFilterInsideModal.layer.cornerRadius = 8
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
        let pokeDetailedSB = UIStoryboard(name: "PokeDetailed", bundle: nil)
        let pokeDetailedVC = pokeDetailedSB.instantiateViewController(withIdentifier: "PokeDetailed") as! PokeDetailedViewController
        self.navigationController?.pushViewController(pokeDetailedVC, animated: true)
    }
    
}

extension DashboardViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let newWidth = (collectionView.frame.width - 72) / 3.0
        return CGSize(width: newWidth, height: 96)
//        return CGSize(width: 92, height: 96)
    }
    
}

//MARK: API req's
extension DashboardViewController {
    
//    private func getData() {
//
//        for id in 1...151 {
//            let url = "https://pokeapi.co/api/v2/pokemon/\(id)"
//            Alamofire.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil)
//                .responseJSON { response in
//                    switch response.result {
//                        case .success:
//                            if let data = response.data {
//                                do {
//                                    guard let pokemon: Pokemon = try? JSONDecoder().decode(Pokemon.self, from: data) else { return }
//                                    self.pokemonArrayDB.append(pokemon)
//                                    self.pokemonArrayDB = self.pokemonArrayDB.sorted{ $0.id < $1.id }
//                                }
//                            }
//                        case .failure:
//                            break;
//                    }
//                }
//                .response { _ in
//                    self.collectionView.reloadData()
//                    self.setupPokeArrayToDefault()
//                }
//        }
//
//    }

}

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
