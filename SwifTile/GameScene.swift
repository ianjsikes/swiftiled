//
//  GameScene.swift
//  SwifTile
//
//  Created by Avelina Kim on 10/27/15.
//  Copyright (c) 2015 ian. All rights reserved.
//

import SpriteKit
import Foundation

class GameScene: SKScene {
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        print("Loaded")
        if let reader = TMXReader(fileName: "map") {
            reader.beginParsing()
        } else {
            print("Failed to initialize TMXReader")
        }
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
