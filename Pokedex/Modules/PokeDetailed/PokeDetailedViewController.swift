//
//  PokeDetailedViewController.swift
//  Pokedex
//
//  Created by Squad Apps on 21/11/23.
//

import UIKit

class PokeDetailedViewController: HelperControler {
    
    //main infos
    @IBOutlet weak var pokeName: UILabel!
    @IBOutlet weak var pokeID: UILabel!
    @IBOutlet weak var pokeImage: UIImageView!
    
    //first infos
    @IBOutlet weak var type: UILabel!
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
    
    
    private var pokemon: Pokemon?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupPokemonInfos()
        setupScreenVisual(pokemonType: "grass")
    }
    
    func initView(pokemon: Pokemon) {
        self.pokemon = pokemon
    }
    
    private func setupPokemonInfos() {
        guard let pokemon = self.pokemon else { return }
        self.pokeName.text = pokemon.name
        self.pokeID.text = setupVisualForId(id: pokemon.id)
//        self.pokeImage.load(urlString: pokemon.sprites.other.officialArtwork.front_default)
        self.pokeImage.load(urlString: pokemon.sprites.front_default)
        
        self.height.text = (pokemon.height / 10).description + " m"
        self.weight.text = (pokemon.weight / 10).description + " kg"
    }
    
    private func setupScreenVisual(pokemonType: String) {
        
        self.cardView.layer.cornerRadius = 8
        
        switch pokemonType {
        case "bug":
            self.bodyView.backgroundColor = UIColor(named: "bug")
            self.contentView.backgroundColor = UIColor(named: "bug")
            self.titleView.backgroundColor = UIColor(named: "bug")
            break
            
        case "dark":
            self.bodyView.backgroundColor = UIColor(named: "dark")
            self.contentView.backgroundColor = UIColor(named: "dark")
            self.titleView.backgroundColor = UIColor(named: "dark")
            break
            
        case "dragon":
            self.bodyView.backgroundColor = UIColor(named: "dragon")
            self.contentView.backgroundColor = UIColor(named: "dragon")
            self.titleView.backgroundColor = UIColor(named: "dragon")
            break
            
        case "eletric":
            self.bodyView.backgroundColor = UIColor(named: "eletric")
            self.contentView.backgroundColor = UIColor(named: "eletric")
            self.titleView.backgroundColor = UIColor(named: "eletric")
            break
            
        case "fairy":
            self.bodyView.backgroundColor = UIColor(named: "fairy")
            self.contentView.backgroundColor = UIColor(named: "fairy")
            self.titleView.backgroundColor = UIColor(named: "fairy")
            break
            
        case "fighting":
            self.bodyView.backgroundColor = UIColor(named: "figthing")
            self.contentView.backgroundColor = UIColor(named: "figthing")
            self.titleView.backgroundColor = UIColor(named: "figthing")
            break
            
        case "fire":
            self.bodyView.backgroundColor = UIColor(named: "fire")
            self.contentView.backgroundColor = UIColor(named: "fire")
            self.titleView.backgroundColor = UIColor(named: "fire")
            break
            
        case "flying":
            self.bodyView.backgroundColor = UIColor(named: "flying")
            self.contentView.backgroundColor = UIColor(named: "flying")
            self.titleView.backgroundColor = UIColor(named: "flying")
            break
            
        case "ghost":
            self.bodyView.backgroundColor = UIColor(named: "ghost")
            self.contentView.backgroundColor = UIColor(named: "ghost")
            self.titleView.backgroundColor = UIColor(named: "ghost")
            break
            
        case "normal":
            self.bodyView.backgroundColor = UIColor(named: "normal")
            self.contentView.backgroundColor = UIColor(named: "normal")
            self.titleView.backgroundColor = UIColor(named: "normal")
            break
            
        case "grass":
            self.bodyView.backgroundColor = UIColor(named: "grass")
            self.contentView.backgroundColor = UIColor(named: "grass")
            self.titleView.backgroundColor = UIColor(named: "grass")
            break
            
        case "ground":
            self.bodyView.backgroundColor = UIColor(named: "ground")
            self.contentView.backgroundColor = UIColor(named: "ground")
            self.titleView.backgroundColor = UIColor(named: "ground")
            break
            
        case "ice":
            self.bodyView.backgroundColor = UIColor(named: "ice")
            self.contentView.backgroundColor = UIColor(named: "ice")
            self.titleView.backgroundColor = UIColor(named: "ice")
            break
            
        case "poison":
            self.bodyView.backgroundColor = UIColor(named: "poison")
            self.contentView.backgroundColor = UIColor(named: "poison")
            self.titleView.backgroundColor = UIColor(named: "poison")
            break
            
        case "psychic":
            self.bodyView.backgroundColor = UIColor(named: "psychic")
            self.contentView.backgroundColor = UIColor(named: "psychic")
            self.titleView.backgroundColor = UIColor(named: "psychic")
            break
            
        case "rock":
            self.bodyView.backgroundColor = UIColor(named: "rock")
            self.contentView.backgroundColor = UIColor(named: "rock")
            self.titleView.backgroundColor = UIColor(named: "rock")
            break
            
        case "steel":
            self.bodyView.backgroundColor = UIColor(named: "steel")
            self.contentView.backgroundColor = UIColor(named: "steel")
            self.titleView.backgroundColor = UIColor(named: "steel")
            break
            
        case "water":
            self.bodyView.backgroundColor = UIColor(named: "water")
            self.contentView.backgroundColor = UIColor(named: "water")
            self.titleView.backgroundColor = UIColor(named: "water")
            break
            
        default:
            self.bodyView.backgroundColor = UIColor(named: "defaultBackground")
            self.contentView.backgroundColor = UIColor(named: "defaultBackground")
            self.titleView.backgroundColor = UIColor(named: "defaultBackground")
            break
        }
    }
    
    @IBAction func returnToDashboard(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
