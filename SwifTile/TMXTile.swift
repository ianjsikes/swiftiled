//
//  TMXTile.swift
//  SwifTile
//
//  Created by Avelina Kim on 11/9/15.
//  Copyright © 2015 ian. All rights reserved.
//

import Foundation

class TMXTile : NSObject {
    var id : Int = 0
    var properties : [String : String] = [:]
    
    override var description : String {
        return "\n\t\t\tTile: \(id)\n\t\t\t\tProperties: \(properties)"
    }
    
    //var terrain : [TMXTerrain]?
    //var probability : Float?
    //var animation : [TMXAnimationFrame]?
    
//    init(id : Int) {
//        self.id = id
//    }
    
    func createTile(attributes : [String : String]) {
        if let id = attributes["id"] {
            self.id = (id as NSString).integerValue
        }
    }
    
    func addProperty(attributes : [String : String]) {
        if let key = attributes["name"] {
            if let value = attributes["value"] {
                properties[key] = value
            }
        }
    }
}

struct TMXAnimationFrame {
    var tileID : Int
    var duration : Float
}