//
//  CollectionViewCellPokeCell.swift
//  Pokedex
//
//  Created by Squad Apps on 31/10/23.
//

import UIKit

class CollectionViewCellPokeCell: UICollectionViewCell {
    
    private var cornerRadius: CGFloat = 8
    private var pokemon: Pokemon?
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var id: UILabel!
    @IBOutlet weak var photo: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupVisual()
    }

    //https://www.advancedswift.com/uicollectionviewcell-rounded-corners-and-shadow-swift/#:~:text=masksToBounds%20%3D%20false-,Shadows%20on%20a%20UICollectionViewCell,to%20the%20desired%20shadow%20design.
    private func setupVisual() {
        self.layer.cornerRadius = cornerRadius
        self.layer.masksToBounds = false
        
        self.contentView.layer.cornerRadius = cornerRadius
        self.contentView.layer.masksToBounds = true
        
        self.layer.shadowRadius = 3
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.80
        self.layer.shadowOffset = CGSize(width: 0, height: 1)
    }
    
    func bind(pokemon: Pokemon) {
        self.pokemon = pokemon
        self.name.text = pokemon.name
        self.id.text = setupVisualForId(id: pokemon.id)
//        self.photo.load(urlString: pokemon.sprites.other.officialArtwork.front_default)
        self.photo.load(urlString: pokemon.sprites.front_default)
    }
    
    func setupVisualForId (id: Int) -> String {
        switch true {
        case id < 10:
            return "#00\(id)"
            
        case id < 100:
            return "#0\(id)"
            
        case id >= 100:
            return "#\(id)"
        
        default:
            return ""
        }
    }
    
}
