//
//  PokeCell.swift
//  pokedex3
//
//  Created by Le Anh Duc on 3/20/17.
//  Copyright © 2017 Le Anh Duc. All rights reserved.
//

import UIKit

class PokeCell: UICollectionViewCell {
    @IBOutlet weak var thumbImg: UIImageView!
    @IBOutlet weak var pokeName: UILabel!
    
    var pokemon:Pokemon!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        layer.cornerRadius = 5.0
        
    }
    
    func configureCell(_ pokemon:Pokemon){
        
        self.pokemon = pokemon
        
        pokeName.text = self.pokemon.name
        thumbImg.image = UIImage(named: "\(self.pokemon.id)")
        
    }
    
}
