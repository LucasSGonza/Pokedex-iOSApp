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
    @IBOutlet weak var centralView: UIView!
    
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
        
        setupScreenToEmptyState()
        
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
                
                if flag { //quando acabar as reqs
                    
                    //caso esteja rodando o refresh da collection, tira-lo
                    if self.refreshControl.isRefreshing {
                        self.refreshControl.endRefreshing()
                    }
                    
                    //procedimento padrão de sucesso
                    self.collectionView.reloadData()
                    self.setupCustomArrayToDefault()
                    self.dismissLoadinAlert()
                    self.viewForError.isHidden = true
                    self.searchBar.isUserInteractionEnabled = true
                    self.filterButton.isUserInteractionEnabled = true
                    
                    //caso não tenha vindo todos os pokemons esperados, avisar o usuário
                    if self.pokemonArrayDB.count != 151 {
                        self.setupAlertForInformation(title: "Warning!", message: "Not all pokemons were loaded from the API!")
                        self.showAlertForInformation()
                    }
                }
            }
            //else trata o .failure da requisição, ou seja, se não der para criar um pokemon
            else {
                if flag {
                    //caso nao exista esse num minimo de pokemons, apresenta erro para tentar novamente
                    if self.pokemonArrayDB.count < 10 {
                        self.setupScreenToEmptyState()
                    }
                    
                    //caso esteja rodando o refresh da collection, tira-lo
                    if self.refreshControl.isRefreshing {
                        self.refreshControl.endRefreshing()
                    }
                    
                    //procedimento padrão de erro
                    self.collectionView.reloadData()
                    self.setupCustomArrayToDefault()
                    self.dismissLoadinAlert()
                    self.showErrorAlert(message: reqMessage)
                    self.viewForError.isHidden = false
                    self.searchBar.isUserInteractionEnabled = false
                    self.filterButton.isUserInteractionEnabled = false
                }
            }
        })
    }
    
    //MARK: reload data from API
    @IBAction func reloadDataFromAPI(_ sender: Any) {
        getDataFromAPI()
    }

    //MARK: my setup functions
    private func startAllSetupFunctions() {
        setupVisualStructure()
        setupCollectionView()
        setupSearchBar()
        setupModalOptionBtts()
        setupAlerts()
    }
    
    //used when an error occurs
    private func setupScreenToEmptyState() {
        viewForError.isHidden = true
        pokemonArrayDB.removeAll()
        customizedPokemonArray.removeAll()
    }
    
    //setup the visual of the components from the ViewController
    private func setupVisualStructure() {
        filterButton.backgroundColor = UIColor.white
        filterButton.layer.cornerRadius = 16
        filterModal.layer.cornerRadius = 12
        
        centralView.layer.cornerRadius = 16
        
        viewFilterInsideModal.layer.cornerRadius = 8
        tryAgainButtonForError.layer.cornerRadius = 8
    }
    
    private func setupCollectionView() {
        //visual
        collectionView.backgroundColor = UIColor.white
        collectionView.layer.cornerRadius = 16
        collectionView.layer.masksToBounds = true
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "CollectionViewPokeCell", bundle: nil), forCellWithReuseIdentifier: "PokeCell")
        
        collectionView.layer.shadowRadius = 14
        collectionView.layer.shadowColor = UIColor.black.cgColor
        collectionView.layer.shadowOpacity = 0.1
        collectionView.layer.shadowOffset = CGSize(width: 0, height: 0)
        
        refreshControl.tintColor = UIColor.black
        refreshControl.addTarget(self, action: #selector(reloadDataFromAPI), for: .valueChanged)
        collectionView.addSubview(refreshControl)
    }
    
    private func setupSearchBar() {
        //visual
        searchBar.searchTextField.backgroundColor = UIColor.white
        searchBar.searchTextField.leftView?.tintColor = UIColor(named: "pokedex-red")
        searchBar.tintColor = UIColor.black
        searchBar.searchTextField.textColor = UIColor.black
        searchBar.showsCancelButton = false
        searchBar.keyboardType = .alphabet
        
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
    
    private func setupFilterBasedInModal() {
        if isNumberOptionSelected {
            searchBar.keyboardType = .phonePad
        } else {
            searchBar.keyboardType = .alphabet
        }
        self.view.endEditing(true)
        searchBar.becomeFirstResponder()
    }
    
    @objc private func selectNumber() {
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
        
        setupFilterBasedInModal()
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
        
        setupFilterBasedInModal()
    }
    
}

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
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
        searchBar.text = ""
        filterModal.isHidden = true
        setupCustomArrayToDefault()
        collectionView.reloadData()
        self.view.endEditing(true)
    }
    
}
