//
//  TMXMap.swift
//  SwifTile
//
//  Created by Avelina Kim on 11/8/15.
//  Copyright © 2015 ian. All rights reserved.
//

import Foundation
import SpriteKit

class TMXMap: NSObject {
    var version : Float = 1.0
    var orientation : Orientation = .orthogonal
    var renderOrder : RenderOrder = .LeftDown
    var width : Int = 0
    var height : Int = 0
    var tileWidth : Int = 0
    var tileHeight : Int = 0
    var backgroundColor : String?
    //var nextObjectID : Int
    var properties : [String : String]?
    
    var tilesets : [TMXTileset] = []
    var layers : [TMXLayer] = []
    var objectGroups : String?
    var imageLayers : String?
    
    override var description : String {
        return "MAP:\n\tVersion: \(version),\n\tOrientation: \(orientation),\n\tRender Order: \(renderOrder),\n\tWidth: \(width),\n\tHeight: \(height),\n\tTile Width: \(tileWidth),\n\tTile Height: \(tileHeight),\n\tTilesets: \(tilesets),\n\tLayers: \(layers)"
    }
    
    func getSpriteByGID(gid : Int) -> SKTexture? {
        var id = gid
        var remainder = 0
        var set = tilesets[0]
        for i in 0..<tilesets.count {
            set = tilesets[i]
            if (id + remainder) <= set.tileCount {
                return set.getSprite(id)
            } else {
                remainder += set.tileCount
                id = gid - remainder
            }
        }
        
        return nil
    }
    
    
    func createMap(attributes : [String : String]) {
        //        self.version = getProp("version", attributes)?.floatValue
        //        if let order = attributes["renderorder"] {
        //            self.renderOrder = TMXMap.RenderOrder(rawValue: order)
        //        }
        //        if let orientation = attributes["orientation"] {
        //            self.orientation = TMXMap.Orientation(rawValue: orientation)
        //        }
        //
        //        self.width = getProp("width", attributes)?.integerValue
        //        self.height = getProp("height", attributes)?.integerValue
        //        self.tileWidth = getProp("tilewidth", attributes)?.integerValue
        //        self.tileHeight = getProp("tileheight", attributes)?.integerValue
        if let version = attributes["version"] {
            self.version = (version as NSString).floatValue
        }
        if let order = attributes["renderorder"] {
            if let renderOrder = TMXMap.RenderOrder(rawValue: order) {
                self.renderOrder = renderOrder
            }
        }
        if let o = attributes["orientation"] {
            if let orientation = TMXMap.Orientation(rawValue: o) {
                self.orientation = orientation
                if orientation != .orthogonal {
                    print("WARNING: Only orthogonal map types are supported")
                }
            }
        }
        if let width = attributes["width"] {
            self.width = (width as NSString).integerValue
        }
        if let height = attributes["height"] {
            self.height = (height as NSString).integerValue
        }
        if let tileWidth = attributes["tilewidth"] {
            self.tileWidth = (tileWidth as NSString).integerValue
        }
        if let tileHeight = attributes["tileheight"] {
            self.tileHeight = (tileHeight as NSString).integerValue
        }
        
        
        print("Map created")
        //self.printMap()
    }
    
    
    
    
    enum Orientation : String {
        case orthogonal
        case isometric
        case hexagonal
        case staggered
    }
    enum RenderOrder : String {
        case LeftDown = "left-down"
        case LeftUp = "left-up"
        case RightDown = "right-down"
        case RightUp = "right-up"
    }
}