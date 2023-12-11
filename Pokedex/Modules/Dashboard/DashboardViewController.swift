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
    
    //Filter Modal
    @IBOutlet weak var filterModal: UIView!
    @IBOutlet weak var viewFilterInsideModal: UIView!
    @IBOutlet weak var numberOption: UIButton!
    @IBOutlet weak var nameOption: UIButton!
    
    private var isAnyOptionAlreadySelected: Bool = false
    private var isNameOptionSelected: Bool = false
    private var isNumberOptionSelected: Bool = false
    
    //Main attributes used in the project
    private var pokemonArrayDB: [Pokemon] = []
    private var customizedPokemonArray: [Pokemon] = []
    private var apiRepository = APIRepository()
    
    @IBOutlet weak var viewForError: UIView!
    @IBOutlet weak var imageForError: UIImageView!
    @IBOutlet weak var labelForError: UILabel!
    @IBOutlet weak var tryAgainButtonForError: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        startAllSetupFunctions()
        getDataFromAPI()
    }
    
    //MARK: Main function to get data from the PokeAPI
    private func getDataFromAPI() {
        showLoadingAlert()
        apiRepository.getData(
            /*
             flag só é true quando acabar as reqs
             pokemon só existe quando req.response == .success
             sempre ocorrerá as 151 requisições
             */
            completion: { (pokemon, flag, reqMessage) in
            if let pokemon = pokemon {
                self.apiRepository.getTextFromASpecificPokemon(pokemon: pokemon, completion: { text in
                    pokemon.pokemonText = text.replacingOccurrences(of: "\n", with: " ")
                })
                self.pokemonArrayDB.append(pokemon)
                self.pokemonArrayDB = self.pokemonArrayDB.sorted{ $0.id < $1.id }
                
                if flag { //se tudo der certo (todas as reqs derem certo)
                    self.collectionView.reloadData()
                    self.setupCustomArrayToDefault()
                    self.dismissLoadinAlert()
                    self.viewForError.isHidden = true
                }
            }
            //else trata o .failure da requisição, ou seja, se não der para criar um pokemon
            else {
                if flag {
                    self.collectionView.reloadData()
                    self.setupCustomArrayToDefault()
                    self.dismissLoadinAlert()
                    self.showErrorAlert(message: reqMessage)
                    self.viewForError.isHidden = false
                }
            }
        })
    }
    
    @IBAction func reloadDataFromAPI(_ sender: Any) {
        getDataFromAPI()
    }
    
    
    //MARK: my setup functions
    private func startAllSetupFunctions() {
        setupVisualStructure()
        setupCollectionView()
        setupSearchBar()
        setupModalOptionBtts()
    }
    
    private func setupVisualStructure() {
        filterButton.backgroundColor = UIColor.white
        filterButton.layer.cornerRadius = 16
        filterModal.layer.cornerRadius = 12
        viewFilterInsideModal.layer.cornerRadius = 8
        tryAgainButtonForError.layer.cornerRadius = 8
        
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
    
    private func setupModalOptionBtts() {
        numberOption.addTarget(self, action: #selector(selectNumber), for: .touchUpInside)
        nameOption.addTarget(self, action: #selector(selectName), for: .touchUpInside)
    }
    
    @objc private func selectNumber() {
//        print(
//        """
//            isNumberOptionSelected: \(isNumberOptionSelected),
//            isNameOptionSelected: \(isNameOptionSelected),
//            isAnyOptionAlreadySelected: \(isAnyOptionAlreadySelected)
//            ==============
//        """)
        
        if isNumberOptionSelected {
            numberOption.setBackgroundImage(UIImage(named: "unselectedBtt"), for: .normal)
            isNumberOptionSelected = false
            isAnyOptionAlreadySelected = false
        } else if isAnyOptionAlreadySelected {
            nameOption.setBackgroundImage(UIImage(named: "unselectedBtt"), for: .normal)
            isNameOptionSelected = false
            
            isNumberOptionSelected = true
            numberOption.setBackgroundImage(UIImage(named: "selectedBtt"), for: .normal)
        } else {
            isNumberOptionSelected = true
            isAnyOptionAlreadySelected = true
            numberOption.setBackgroundImage(UIImage(named: "selectedBtt"), for: .normal)
        }
    }
    
    @objc private func selectName() {
        if isNameOptionSelected {
            nameOption.setBackgroundImage(UIImage(named: "unselectedBtt"), for: .normal)
            isNameOptionSelected = false
            isAnyOptionAlreadySelected = false
        } else if isAnyOptionAlreadySelected {
            numberOption.setBackgroundImage(UIImage(named: "unselectedBtt"), for: .normal)
            isNumberOptionSelected = false
            
            isNameOptionSelected = true
            nameOption.setBackgroundImage(UIImage(named: "selectedBtt"), for: .normal)
        } else {
            isNameOptionSelected = true
            isAnyOptionAlreadySelected = true
            nameOption.setBackgroundImage(UIImage(named: "selectedBtt"), for: .normal)
        }
    }
    
//    @objc private func optionSelected(btt: UIButton) {
//        guard let optionImage = btt.backgroundImage(for: .normal) else { return }
//        if optionImage == UIImage(named: "selectedBtt") {
//            btt.setBackgroundImage(UIImage(named: "unselectedBtt"), for: .normal)
//            isFilterSelected = false
//        } else if !isFilterSelected {
//            btt.setBackgroundImage(UIImage(named: "selectedBtt"), for: .normal)
//            isFilterSelected = true
//        }
//    }
    
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
