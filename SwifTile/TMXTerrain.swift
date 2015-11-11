//
//  TMXTerrain.swift
//  SwifTile
//
//  Created by Avelina Kim on 11/9/15.
//  Copyright © 2015 ian. All rights reserved.
//

import Foundation

class TMXTerrain : NSObject {
    var name : String
    var tile : Int
    
    var properties : [String : String]?
    
    init(name : String, tile : Int) {
        self.name = name
        self.tile = tile
    }
}