//
//  Pokemon.swift
//  pokedex3
//
//  Created by Le Anh Duc on 3/20/17.
//  Copyright © 2017 Le Anh Duc. All rights reserved.
//

import Foundation

class Pokemon {
    
    fileprivate var _name:  String!
    fileprivate var _id:    Int!
    
    var name: String {
        return _name
    }
    
    var id: Int {
        return _id
    }
    
    init(name: String, id: Int) {
        _name = name
        _id   = id
    }
    
}
