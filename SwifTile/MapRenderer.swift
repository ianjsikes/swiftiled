//
//  MapRenderer.swift
//  SwifTile
//
//  Created by Avelina Kim on 11/9/15.
//  Copyright © 2015 ian. All rights reserved.
//

import Foundation
import SpriteKit

class MapRenderer : NSObject {
    var map : TMXMap
    
    var mapNode : SKNode
    
    init(map : TMXMap) {
        self.map = map
        self.mapNode = SKNode()
    }
    
    func drawMap() {
        
        for i in 0..<self.map.layers.count {
            let layerNode = self.renderLayer(self.map.layers[i])
            self.mapNode.addChild(layerNode)
        }
    }
    
    func renderLayer(layer : TMXLayer) -> SKNode {
        let layerNode = SKNode()
        
        if let data = layer.data {
            
            for a in 0..<layer.x {
                for b in 0..<layer.y {
                    
                    let index = (b * layer.x) + a
                    let localID = data.gids[index]
                    if localID > 0 {
                        if let sprite = self.map.getSpriteByGID(localID) {
                            let tileNode = SKSpriteNode(texture: sprite)
                            layerNode.addChild(tileNode)
                            tileNode.position = CGPointMake(CGFloat(a) * tileNode.size.width, CGFloat(b) * tileNode.size.height)
                        }
                    }
                    
                }
            }
            
        }
        return layerNode
    }
    
//    func getTilesetFromGID(gid : Int) -> TMXTileset {
//        return TMXTileset()
//        
//        if self.map.tilesets.count == 1 {
//            return self.map.tilesets[0]
//        }
//        
//        for i in 0..<self.map.tilesets.count {
//            
//        }
//    }
}