//
//  PokeDetailedViewController.swift
//  Pokedex
//
//  Created by Squad Apps on 21/11/23.
//

import UIKit

class PokeDetailedViewController: HelperControler {
    
    //MARK: Atributes and elements
    
    //main infos
    @IBOutlet weak var pokeNameLabel: UILabel!
    @IBOutlet weak var pokeIDLabel: UILabel!
    @IBOutlet weak var pokeImage: UIImageView!
    
    //first infos
    @IBOutlet weak var firstType: UILabel!
    @IBOutlet weak var firstTypeAlignConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var secondType: UILabel!
    
    @IBOutlet weak var weight: UILabel!
    @IBOutlet weak var height: UILabel!
    @IBOutlet weak var moves: UILabel!
    @IBOutlet weak var pokeText: UILabel!
    
    //card infos
    @IBOutlet weak var pokeHP: UILabel!
    @IBOutlet weak var pokeATK: UILabel!
    @IBOutlet weak var pokeDEF: UILabel!
    @IBOutlet weak var pokeSATK: UILabel!
    @IBOutlet weak var pokeSDEF: UILabel!
    @IBOutlet weak var pokeSPD: UILabel!
    
    //View's
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var titleView: UIView!
    @IBOutlet weak var bodyView: UIView!
    @IBOutlet weak var cardView: UIView!
    
    //To change pokemon
    @IBOutlet weak var leftArrow: UIButton!
    @IBOutlet weak var rightArrow: UIButton!
    
//    private var pokemon: Pokemon?
    private var pokemonID: Int?
    private var pokemonArray: [Pokemon]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupPokeOnScreen()
    }
    
    //MARK: Init View
    func initView(pokemonID: Int, pokemonArray: [Pokemon]) {
//        self.pokemon = pokemon
        self.pokemonID = pokemonID
        self.pokemonArray = pokemonArray
    }
    
    private func setupPokeOnScreen() {
        setupPokemonInfos()
        isFirstOrLastPokemon(pokemonID: self.pokemonID ?? 1)
    }
    
    //MARK: setup poke infos
//    private func setupPokemonInfos() {
//        guard let pokemon = self.pokemon else { return }
//        self.pokeNameLabel.text = pokemon.name
//        self.pokeIDLabel.text = setupVisualForId(id: pokemon.id)
//        self.pokeImage.load(urlString: pokemon.sprites.other.officialArtwork
//                                .front_default)
//        self.height.text = (pokemon.height / 10).description + " m"
//        self.weight.text = (pokemon.weight / 10).description + " kg"
//
//        setupScreenVisual(pokemonType: pokemon.types[0].type.name)
//    }
    
    private func setupPokemonInfos() {
        guard let pokemonArray = self.pokemonArray else { return }
        guard let pokemon = pokemonArray.first(where: {$0.id == pokemonID}) else { return }
        
        self.pokeNameLabel.text = pokemon.name
        self.pokeIDLabel.text = setupVisualForId(id: pokemon.id)
        self.pokeImage.load(urlString: pokemon.sprites.other.officialArtwork
                                .front_default)
        self.height.text = (pokemon.height / 10).description + " m"
        self.weight.text = (pokemon.weight / 10).description + " kg"
        
        setupScreenVisual(pokemonType: pokemon.types[0].type.name)
        isFirstOrLastPokemon(pokemonID: pokemon.id)
        setupPokemonType(pokemon: pokemon)
    }
    
    private func setupPokemonType(pokemon: Pokemon) {
        //first type == always have
        self.firstType.text = pokemon.types[0].type.name
        
        self.firstType.layer.cornerRadius = 10
        self.firstType.layer.masksToBounds = true
        self.firstType.textColor = UIColor.white
        
        self.secondType.layer.cornerRadius = 10
        self.secondType.layer.masksToBounds = true
        self.secondType.textColor = UIColor.white
        
        self.firstTypeAlignConstraint.constant = 0
        self.secondType.isHidden = true
        
        //if has secondType, apply the same things
        if pokemon.types.count > 1 {
            self.secondType.text = pokemon.types[1].type.name
            self.firstTypeAlignConstraint.constant = -40
            self.secondType.isHidden = false
            setupBackgroundColorBasedOnType(pokemonType: pokemon.types[1].type.name, view: nil, label: self.secondType)
        }
        
    }
    
    //MARK: Change background color
    private func setupScreenVisual(pokemonType: String) {
        
        self.cardView.layer.cornerRadius = 8
        
        switch pokemonType {
        case "bug":
            self.bodyView.backgroundColor = UIColor(named: "bug")
            self.contentView.backgroundColor = UIColor(named: "bug")
            self.titleView.backgroundColor = UIColor(named: "bug")
            self.firstType.backgroundColor = UIColor(named: "bug")
            break
            
        case "dark":
            self.bodyView.backgroundColor = UIColor(named: "dark")
            self.contentView.backgroundColor = UIColor(named: "dark")
            self.titleView.backgroundColor = UIColor(named: "dark")
            self.firstType.backgroundColor = UIColor(named: "dark")
            break
            
        case "dragon":
            self.bodyView.backgroundColor = UIColor(named: "dragon")
            self.contentView.backgroundColor = UIColor(named: "dragon")
            self.titleView.backgroundColor = UIColor(named: "dragon")
            self.firstType.backgroundColor = UIColor(named: "dragon")
            break
            
        case "electric":
            self.bodyView.backgroundColor = UIColor(named: "electric")
            self.contentView.backgroundColor = UIColor(named: "electric")
            self.titleView.backgroundColor = UIColor(named: "electric")
            self.firstType.backgroundColor = UIColor(named: "electric")
            break
            
        case "fairy":
            self.bodyView.backgroundColor = UIColor(named: "fairy")
            self.contentView.backgroundColor = UIColor(named: "fairy")
            self.titleView.backgroundColor = UIColor(named: "fairy")
            self.firstType.backgroundColor = UIColor(named: "fairy")
            break
            
        case "fighting":
            self.bodyView.backgroundColor = UIColor(named: "figthing")
            self.contentView.backgroundColor = UIColor(named: "figthing")
            self.titleView.backgroundColor = UIColor(named: "figthing")
            self.firstType.backgroundColor = UIColor(named: "figthing")
            break
            
        case "fire":
            self.bodyView.backgroundColor = UIColor(named: "fire")
            self.contentView.backgroundColor = UIColor(named: "fire")
            self.titleView.backgroundColor = UIColor(named: "fire")
            self.firstType.backgroundColor = UIColor(named: "fire")
            break
            
        case "flying":
            self.bodyView.backgroundColor = UIColor(named: "flying")
            self.contentView.backgroundColor = UIColor(named: "flying")
            self.titleView.backgroundColor = UIColor(named: "flying")
            self.firstType.backgroundColor = UIColor(named: "flying")
            break
            
        case "ghost":
            self.bodyView.backgroundColor = UIColor(named: "ghost")
            self.contentView.backgroundColor = UIColor(named: "ghost")
            self.titleView.backgroundColor = UIColor(named: "ghost")
            self.firstType.backgroundColor = UIColor(named: "ghost")
            break
            
        case "normal":
            self.bodyView.backgroundColor = UIColor(named: "normal")
            self.contentView.backgroundColor = UIColor(named: "normal")
            self.titleView.backgroundColor = UIColor(named: "normal")
            self.firstType.backgroundColor = UIColor(named: "normal")
            break
            
        case "grass":
            self.bodyView.backgroundColor = UIColor(named: "grass")
            self.contentView.backgroundColor = UIColor(named: "grass")
            self.titleView.backgroundColor = UIColor(named: "grass")
            self.firstType.backgroundColor = UIColor(named: "grass")
            break
            
        case "ground":
            self.bodyView.backgroundColor = UIColor(named: "ground")
            self.contentView.backgroundColor = UIColor(named: "ground")
            self.titleView.backgroundColor = UIColor(named: "ground")
            self.firstType.backgroundColor = UIColor(named: "ground")
            break
            
        case "ice":
            self.bodyView.backgroundColor = UIColor(named: "ice")
            self.contentView.backgroundColor = UIColor(named: "ice")
            self.titleView.backgroundColor = UIColor(named: "ice")
            self.firstType.backgroundColor = UIColor(named: "ice")
            break
            
        case "poison":
            self.bodyView.backgroundColor = UIColor(named: "poison")
            self.contentView.backgroundColor = UIColor(named: "poison")
            self.titleView.backgroundColor = UIColor(named: "poison")
            self.firstType.backgroundColor = UIColor(named: "poison")
            break
            
        case "psychic":
            self.bodyView.backgroundColor = UIColor(named: "psychic")
            self.contentView.backgroundColor = UIColor(named: "psychic")
            self.titleView.backgroundColor = UIColor(named: "psychic")
            self.firstType.backgroundColor = UIColor(named: "psychic")
            break
            
        case "rock":
            self.bodyView.backgroundColor = UIColor(named: "rock")
            self.contentView.backgroundColor = UIColor(named: "rock")
            self.titleView.backgroundColor = UIColor(named: "rock")
            self.firstType.backgroundColor = UIColor(named: "rock")
            break
            
        case "steel":
            self.bodyView.backgroundColor = UIColor(named: "steel")
            self.contentView.backgroundColor = UIColor(named: "steel")
            self.titleView.backgroundColor = UIColor(named: "steel")
            self.firstType.backgroundColor = UIColor(named: "steel")
            break
            
        case "water":
            self.bodyView.backgroundColor = UIColor(named: "water")
            self.contentView.backgroundColor = UIColor(named: "water")
            self.titleView.backgroundColor = UIColor(named: "water")
            self.firstType.backgroundColor = UIColor(named: "water")
            break
            
        default:
            self.bodyView.backgroundColor = UIColor(named: "defaultBackground")
            self.contentView.backgroundColor = UIColor(named: "defaultBackground")
            self.titleView.backgroundColor = UIColor(named: "defaultBackground")
            self.firstType.backgroundColor = UIColor(named: "defaultBackground")
            break
        }
    }
    
    //MARK: Return to dashboard
    @IBAction func returnToDashboard(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func moveBackward(_ sender: Any) {
        guard let pokemonID = self.pokemonID else { return }
        self.pokemonID = pokemonID - 1
        print(self.pokemonID ?? 1)
        setupPokemonInfos()
    }
    
    @IBAction func moveForward(_ sender: Any) {
        guard let pokemonID = self.pokemonID else { return }
        self.pokemonID = pokemonID + 1
        print(self.pokemonID ?? 1)
        setupPokemonInfos()
    }
    
    
    //MARK: Moving between poke's
    private func isFirstOrLastPokemon(pokemonID: Int) {
        
        if pokemonID == 1 {
            leftArrow.isHidden = true
        } else {
            leftArrow.isHidden = false
        }
        
        if pokemonID == 151 {
            rightArrow.isHidden = true
        } else {
            rightArrow.isHidden = false
        }
        
    }
    
}
