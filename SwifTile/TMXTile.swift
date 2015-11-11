//
//  TMXTile.swift
//  SwifTile
//
//  Created by Avelina Kim on 11/9/15.
//  Copyright © 2015 ian. All rights reserved.
//

import Foundation

class TMXTile : NSObject {
    var id : Int
    
    var terrain : [TMXTerrain]?
    var probability : Float?
    var animation : [TMXAnimationFrame]?
    
    init(id : Int) {
        self.id = id
    }
}

struct TMXAnimationFrame {
    var tileID : Int
    var duration : Float
}