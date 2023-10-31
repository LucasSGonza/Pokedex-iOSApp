//
//  CollectionViewCellPokeCell.swift
//  Pokedex
//
//  Created by Squad Apps on 31/10/23.
//

import UIKit

class CollectionViewCellPokeCell: UICollectionViewCell {
    
    private var cornerRadius: CGFloat = 8
    
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
    
}
