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
    
    //progress infos for the card infos
    //By default, the progress is 0.0 and the total is 1.0.
    @IBOutlet weak var progressHP: UIProgressView!
    @IBOutlet weak var progressATK: UIProgressView!
    @IBOutlet weak var progresDEF: UIProgressView!
    @IBOutlet weak var progressSATK: UIProgressView!
    @IBOutlet weak var progressSDEF: UIProgressView!
    @IBOutlet weak var progressSPD: UIProgressView!
    
    //View's
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var titleView: UIView!
    @IBOutlet weak var bodyView: UIView!
    @IBOutlet weak var cardView: UIView!
    
    //To change pokemon
    @IBOutlet weak var leftArrow: UIButton!
    @IBOutlet weak var rightArrow: UIButton!
    
    private var pokemonID: Int?
    private var pokemonArray: [Pokemon]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupPokeOnScreen()
    }
    
    //MARK: Init View
    func initView(pokemonID: Int, pokemonArray: [Pokemon]) {
        self.pokemonID = pokemonID
        self.pokemonArray = pokemonArray
    }
    
    private func setupPokeOnScreen() {
        setupPokemonInfos()
        isFirstOrLastPokemon(pokemonID: self.pokemonID ?? 1)
    }
    
    //MARK: setup poke infos (works as a reloadData)
    private func setupPokemonInfos() {
        guard let pokemonArray = self.pokemonArray, let pokemon = pokemonArray.first(where: {$0.id == pokemonID}) else { return }
        
        self.pokeNameLabel.text = pokemon.name
        self.pokeIDLabel.text = setupVisualForId(id: pokemon.id)
        self.pokeImage.load(urlString: pokemon.sprites.other.officialArtwork
                                .front_default)
        self.height.text = (pokemon.height / 10).description + " m"
        self.weight.text = (pokemon.weight / 10).description + " kg"
        
        self.moves.text = ""
        pokemon.abilities.forEach { (a:Pokemon.ItemAbility) in
            self.moves.text = self.moves.text! + "\n" + a.ability.name
        }
        
        self.pokeHP.text = self.setupVisualForStats(stat: pokemon.stats[0].base_stat)
//        self.progressHP.progress = ()
        
        self.pokeATK.text = self.setupVisualForStats(stat: pokemon.stats[1].base_stat)
        self.pokeDEF.text = self.setupVisualForStats(stat: pokemon.stats[2].base_stat)
        self.pokeSATK.text = self.setupVisualForStats(stat: pokemon.stats[3].base_stat)
        self.pokeSDEF.text = self.setupVisualForStats(stat: pokemon.stats[4].base_stat)
        self.pokeSPD.text = self.setupVisualForStats(stat: pokemon.stats[5].base_stat)
        
        isFirstOrLastPokemon(pokemonID: pokemon.id)
        setupVisualBasedOnPokemonType(pokemon: pokemon)
    }
    
    private func setupVisualBasedOnPokemonType(pokemon: Pokemon) {
        //first type == always have
        self.firstType.text = pokemon.types[0].type.name
        self.firstType.layer.cornerRadius = 10
        self.firstType.layer.masksToBounds = true
        self.firstType.textColor = UIColor.white
        self.firstType.backgroundColor = UIColor(named: "\(pokemon.types[0].type.name)")
        
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
            self.secondType.backgroundColor = UIColor(named: "\(pokemon.types[1].type.name)")
        }
        
        setupScreenVisual(pokemon: pokemon)
    }
    
    //MARK: Change background color
    private func setupScreenVisual(pokemon: Pokemon) {
        bodyView.setupBackgroundColorBasedOnType(pokemonType: pokemon.types[0].type.name)
        titleView.setupBackgroundColorBasedOnType(pokemonType: pokemon.types[0].type.name)
        contentView.setupBackgroundColorBasedOnType(pokemonType: pokemon.types[0].type.name)
        cardView.layer.cornerRadius = 8
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
