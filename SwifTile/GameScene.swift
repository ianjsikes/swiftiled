//
//  GameScene.swift
//  SwifTile
//
//  Created by Avelina Kim on 10/27/15.
//  Copyright (c) 2015 ian. All rights reserved.
//

import SpriteKit
import Foundation

class GameScene: SKScene, TMXReaderDelegate {
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        print("Loaded")
        if let reader = TMXReader(fileName: "map", delegate: self) {
            reader.beginParsing()
        } else {
            print("Failed to initialize TMXReader")
        }
    }
    
    func onReaderCompleted(map : TMXMap) {
        let renderer = MapRenderer(map: map)
        renderer.drawMap()
        let mNode = renderer.mapNode
        self.addChild(mNode)
        mNode.position = CGPointMake(self.frame.width / 5, self.frame.height / 3)
        mNode.setScale(1.3)
        //print(mNode.children[0].children)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
       /* Called when a touch begins */
        
//        for touch in touches {
//            
//        }
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
