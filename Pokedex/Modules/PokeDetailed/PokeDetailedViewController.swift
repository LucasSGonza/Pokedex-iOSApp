//
//  PokeDetailedViewController.swift
//  Pokedex
//
//  Created by Squad Apps on 21/11/23.
//

import UIKit

class PokeDetailedViewController: HelperControler {
    
    //MARK: Attributes and elements
    
    //main infos
    @IBOutlet weak var pokeNameLabel: UILabel!
    @IBOutlet weak var pokeIDLabel: UILabel!
    @IBOutlet weak var pokeImage: UIImageView!
    
    //first infos
    @IBOutlet weak var firstTypeLabel: UILabel!
    
    @IBOutlet weak var secondTypeView: UIView!
    @IBOutlet weak var secondTypeLabel: UILabel!
    
    @IBOutlet weak var aboutLabel: UILabel!
    @IBOutlet weak var baseStatsLabel: UILabel!
    
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var movesLabel: UILabel!
    @IBOutlet weak var pokeTextLabel: UILabel!
    
    //label infos for the pokemon stats
    @IBOutlet weak var pokeHP: UILabel!
    @IBOutlet weak var pokeATK: UILabel!
    @IBOutlet weak var pokeDEF: UILabel!
    @IBOutlet weak var pokeSATK: UILabel!
    @IBOutlet weak var pokeSDEF: UILabel!
    @IBOutlet weak var pokeSPD: UILabel!
    
    //progress infos about the pokemon, based in his stats
    @IBOutlet weak var progressHP: UIProgressView!
    @IBOutlet weak var progressATK: UIProgressView!
    @IBOutlet weak var progressDEF: UIProgressView!
    @IBOutlet weak var progressSATK: UIProgressView!
    @IBOutlet weak var progressSDEF: UIProgressView!
    @IBOutlet weak var progressSPD: UIProgressView!
    
    //View's and imageView's
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var titleView: UIView!
    @IBOutlet weak var bodyView: UIView!
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var pokeBallBackground: UIImageView!
    
    //To change pokemon
    @IBOutlet weak var leftArrow: UIButton!
    @IBOutlet weak var rightArrow: UIButton!
    
    private var pokemonID: Int?
    private var pokemonArray: [Pokemon]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupPokemonInfos()
    }
    
    //MARK: Init View
    func initView(pokemonID: Int, pokemonArray: [Pokemon]) {
        self.pokemonID = pokemonID
        self.pokemonArray = pokemonArray
    }
    
    //MARK: setup poke infos (works as a reloadData)
    private func setupPokemonInfos() {
        //sempre criará um novo pokemon, baseado no ID atual
        guard let pokemonArray = self.pokemonArray, let pokemon = pokemonArray.first(where: {$0.id == pokemonID}) else { return }
        
        pokeBallBackground.layer.opacity = 0.2
        
        pokeNameLabel.text = pokemon.name
        pokeIDLabel.text = setupVisualForId(id: pokemon.id)
        pokeImage.load(urlString: pokemon.sprites.other.officialArtwork.front_default)
        
        aboutLabel.textColor = UIColor(named: pokemon.types[0].type.name)
        
        heightLabel.text = (pokemon.height / 10).description + " m"
        weightLabel.text = (pokemon.weight / 10).description + " kg"
        
        movesLabel.text = ""
        pokemon.abilities.forEach { (a:Pokemon.ItemAbility) in
            movesLabel.text = self.movesLabel.text! + "\n" + a.ability.name
        }
        
        baseStatsLabel.textColor = UIColor(named: pokemon.types[0].type.name)
        pokeTextLabel.text = pokemon.pokemonText
        
        pokeHP.text = self.setupVisualForStats(stat: pokemon.stats[0].base_stat)
        pokeATK.text = self.setupVisualForStats(stat: pokemon.stats[1].base_stat)
        pokeDEF.text = self.setupVisualForStats(stat: pokemon.stats[2].base_stat)
        pokeSATK.text = self.setupVisualForStats(stat: pokemon.stats[3].base_stat)
        pokeSDEF.text = self.setupVisualForStats(stat: pokemon.stats[4].base_stat)
        pokeSPD.text = self.setupVisualForStats(stat: pokemon.stats[5].base_stat)
        
        isFirstOrLastPokemon(pokemonID: pokemon.id)
        setupVisualBasedOnPokemonType(pokemon: pokemon)
        setupProgressView()
    }
    
    //MARK: setup general visual of the itens on screen
    private func setupVisualBasedOnPokemonType(pokemon: Pokemon) {
        //first type == always have
        self.firstTypeLabel.text = pokemon.types[0].type.name
        self.firstTypeLabel.layer.cornerRadius = 9
        self.firstTypeLabel.layer.masksToBounds = true
        self.firstTypeLabel.textColor = UIColor.white
        self.firstTypeLabel.backgroundColor = UIColor(named: "\(pokemon.types[0].type.name)")
        
        self.secondTypeLabel.layer.cornerRadius = 9
        self.secondTypeLabel.layer.masksToBounds = true
        self.secondTypeLabel.textColor = UIColor.white
        
        secondTypeView.isHidden = true
        
        //if has secondType, apply the same things
        if pokemon.types.count > 1 {
            self.secondTypeLabel.text = pokemon.types[1].type.name
            secondTypeView.isHidden = false
            self.secondTypeLabel.backgroundColor = UIColor(named: "\(pokemon.types[1].type.name)")
        }
        
        setupScreenVisual(pokemon: pokemon)
    }
    
    //MARK: Change background visual color, based in the pokemon first type
    private func setupScreenVisual(pokemon: Pokemon) {
        self.view.backgroundColor = setupBackgroundColorBasedOnPokeType(pokemonType: pokemon.types[0].type.name)
        bodyView.backgroundColor = setupBackgroundColorBasedOnPokeType(pokemonType: pokemon.types[0].type.name)
        titleView.backgroundColor = setupBackgroundColorBasedOnPokeType(pokemonType: pokemon.types[0].type.name)
        contentView.backgroundColor = setupBackgroundColorBasedOnPokeType(pokemonType: pokemon.types[0].type.name)
        
        cardView.layer.cornerRadius = 8
        cardView.layer.masksToBounds = true
        
        cardView.layer.shadowRadius = 14
        cardView.layer.shadowColor = UIColor.black.cgColor
        cardView.layer.shadowOpacity = 0.1
        cardView.layer.shadowOffset = CGSize(width: 0, height: 0)
    }
    
    //MARK: Return to dashboard
    @IBAction func returnToDashboard(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    //MARK: func's to move between pokemons
    @IBAction func moveBackward(_ sender: Any) {
        guard let pokemonID = self.pokemonID else { return }
        self.pokemonID = pokemonID - 1
        setupPokemonInfos()
    }
    
    @IBAction func moveForward(_ sender: Any) {
        guard let pokemonID = self.pokemonID else { return }
        self.pokemonID = pokemonID + 1
        setupPokemonInfos()
    }
    
    
    //MARK: func to hide or not the arrow's to change between pokemons
    private func isFirstOrLastPokemon(pokemonID: Int) {
        guard let pokemonArray = pokemonArray else { return }

//        print(pokemonArray.first(where: {$0.id == pokemonID - 1})?.name ?? "nil")
        
        if pokemonArray.first(where: {$0.id == pokemonID - 1}) != nil {
            leftArrow.isHidden = (pokemonID == 1 ? true : false)
        } else {
            leftArrow.isHidden = true
        }
        
        if pokemonArray.first(where: {$0.id == pokemonID + 1}) != nil {
            rightArrow.isHidden = (pokemonID == 151 ? true : false)
        } else {
            rightArrow.isHidden = true
        }
        
//        leftArrow.isHidden = (pokemonID == 1 ? true : false)
//        rightArrow.isHidden = (pokemonID == 151 ? true : false)
    }
    
}

//MARK: setup ProgressView
extension PokeDetailedViewController {
    
    //pegar o valor do status e comparar para saber o progresso
    private func setupProgressView() {
        guard let pokemon = self.pokemonArray?.first(where: {$0.id == pokemonID}) else { return }
        
        //visual da barra
        progressHP.progressTintColor = UIColor(named: pokemon.types[0].type.name)
        progressDEF.progressTintColor = UIColor(named: pokemon.types[0].type.name)
        progressATK.progressTintColor = UIColor(named: pokemon.types[0].type.name)
        progressSATK.progressTintColor = UIColor(named: pokemon.types[0].type.name)
        progressSDEF.progressTintColor = UIColor(named: pokemon.types[0].type.name)
        progressSPD.progressTintColor = UIColor(named: pokemon.types[0].type.name)
        
        //definir a "porcentagem" do progresso (pega o valor e / maximo)
        progressHP.progress = calculateProgress(statValue: pokemon.stats[0].base_stat)
        progressATK.progress = calculateProgress(statValue: pokemon.stats[1].base_stat)
        progressDEF.progress = calculateProgress(statValue: pokemon.stats[2].base_stat)
        progressSATK.progress = calculateProgress(statValue: pokemon.stats[3].base_stat)
        progressSDEF.progress = calculateProgress(statValue: pokemon.stats[4].base_stat)
        progressSPD.progress = calculateProgress(statValue: pokemon.stats[5].base_stat)
    }
    
    private func calculateProgress(statValue: Int) -> Float {
        return (Float(statValue) / 300)
    }
    
}
