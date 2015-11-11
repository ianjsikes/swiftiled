//
//  TMXTileset.swift
//  SwifTile
//
//  Created by Avelina Kim on 11/8/15.
//  Copyright © 2015 ian. All rights reserved.
//

import Foundation
import SpriteKit

class TMXTileset: NSObject {
    var firstGID : Int = 1
    //var source : String?
    var name : String = ""
    var tileWidth : Int = 0
    var tileHeight : Int = 0
    var spacing : Int = 0
    var margin : Int = 0
    var tileCount : Int = 0
    
    var tileOffset : (Int, Int) = (0, 0)
    var imageName : String = ""
    var spriteSheet : SpriteSheet?
    var terrainTypes : [TMXTerrain]?
    
    override var description : String {
        return "\n\t\tTILESET: \(name),\n\t\tFirst GID: \(firstGID),\n\t\tTile Width: \(tileWidth),\n\t\tTile Height: \(tileHeight),\n\t\tSpacing: \(spacing),\n\t\tMargin: \(margin),\n\t\tTile Count: \(tileCount),\n\t\tTile Offset: \(tileOffset),\n\t\tImage Name: \(imageName)"
    }
    
    func setSpriteSheet() {
        spriteSheet = SpriteSheet(imageName: self.imageName,
                                  spriteWidth: self.tileWidth,
                                  spriteHeight: self.tileHeight,
                                  margin: self.margin,
                                  spacing: self.spacing)
    }
    
    func getSprite(localID : Int) -> SKTexture? {
        if let sheet = self.spriteSheet {
            return sheet.getSprite(localID)
        } else {
            return nil
        }
    }
    
    
    func createTileset(attributes : [String : String]) {
        if let firstGID = attributes["firstgid"] {
            self.firstGID = (firstGID as NSString).integerValue
        }
        if let source = attributes["source"] {
            var split = source.componentsSeparatedByString("/")
            var filename = split[split.count - 1]
            split = source.componentsSeparatedByString(".")
            filename = split[0]
            
            if let reader = TSXReader(fileName: filename, tileset: self) {
                reader.beginParsing()
            } else {
                print("Failed to initialize TSXReader")
            }
            
        }
        if let name = attributes["name"] {
            self.name = name
        }
        if let tileWidth = attributes["tilewidth"] {
            self.tileWidth = (tileWidth as NSString).integerValue
        }
        if let tileHeight = attributes["tileheight"] {
            self.tileHeight = (tileHeight as NSString).integerValue
        }
        if let spacing = attributes["spacing"] {
            self.spacing = (spacing as NSString).integerValue
        }
        if let margin = attributes["margin"] {
            self.margin = (margin as NSString).integerValue
        }
        if let tileCount = attributes["tilecount"] {
            self.tileCount = (tileCount as NSString).integerValue
        }
    }
    
    
    
}




