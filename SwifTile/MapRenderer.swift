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
        self.mapNode.name = "map"
        self.mapNode.position = CGPointMake(0, 0)
    }
    
    func drawMap() {
        
        for i in 0..<self.map.layers.count {
            let layerNode = self.renderLayer(self.map.layers[i])
            layerNode.position = CGPointMake(0, 0)
            self.mapNode.addChild(layerNode)
        }
        print("Map rendered")
    }
    
    func renderLayer(layer : TMXLayer) -> SKNode {
        print("Rendering layer: \(layer.layerName)")
        let layerNode = SKNode()
        layerNode.name = layer.layerName
        
        if let data = layer.data {
            
            print("test")
            print("x: \(layer.width), y: \(layer.height)")
            
            for a in 0..<layer.width {
                for b in 0..<layer.height {
                    
                    let y = layer.height - b - 1
                    
                    let index = (b * layer.width) + a
                    let localID = data.gids[index]
                    if localID > 0 {
                        if let sprite = self.map.getSpriteByGID(localID) {
                            sprite.filteringMode = SKTextureFilteringMode.Nearest
                            let tileNode = SKSpriteNode(texture: sprite)
                            if let props = self.map.getTileProperties(localID - 1) {
                                print("Setting tile properties for tile: \(localID)")
                                self.setNodeProperties(tileNode, props)
                            }
                            layerNode.addChild(tileNode)
                            let pos = CGPointMake(CGFloat(a) * tileNode.size.width, CGFloat(y) * tileNode.size.height)
                            //print("Position: \(pos)")
                            tileNode.position = pos
                        }
                    }
                    
                }
            }
            
        }
        return layerNode
    }
    
    func setNodeProperties(node : SKSpriteNode, _ attrs : [String:String]) {
        //print("Setting node properties")
        for (key, value) in attrs {
            if key == "BodyType" {
                print("Setting physics body")
                let body = SKPhysicsBody(rectangleOfSize: node.size)
                body.dynamic = false
                body.allowsRotation = false
                body.affectedByGravity = false
                body.collisionBitMask = 2
                //body.pinned = true
                body.restitution = 0.0
                
                node.physicsBody = body
            }
        }
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