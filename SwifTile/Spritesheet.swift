//
//  SpriteSheet.swift
//  spyGame
//
//  Created by Avelina Kim on 10/6/15.
//  Copyright (c) 2015 SMC_CPC. All rights reserved.
//

import SpriteKit

//Utility class for turning a single spritesheet image into multiple sprites
//because the built in 'texture atlases' suck and most placeholder art is
//in the form of one single spritesheet.
class SpriteSheet {
    
    var sheetTexture : SKTexture
    var rows : Int = 0
    var cols : Int = 0
    var spacing : CGFloat = 0
    var margin : CGFloat = 0
    var spriteWidth : CGFloat = 0
    var spriteHeight : CGFloat = 0
    
    init(texture: SKTexture, rows: Int, cols: Int, margin: Int = 0, spacing: Int = 0){
        self.sheetTexture = texture
        self.rows = rows
        self.cols = cols
        setSpriteWidthAndHeight()
        setMarginAndSpacing(margin, spacing)
    }
    
    init(imageName: String, rows: Int, cols: Int, margin: Int = 0, spacing: Int = 0){
        self.sheetTexture = SKTexture(imageNamed: imageName)
        self.rows = rows
        self.cols = cols
        setSpriteWidthAndHeight()
        setMarginAndSpacing(margin, spacing)
    }
    
    init(imageName: String, spriteWidth: Int, spriteHeight: Int, margin: Int = 0, spacing: Int = 0){
        self.sheetTexture = SKTexture(imageNamed: imageName)
        setSpriteWidthAndHeight(spriteWidth, spriteHeight)
        setRowsAndCols()
        setMarginAndSpacing(margin, spacing)
    }
    
    func setSpriteWidthAndHeight(){
        self.spriteWidth = 1.0/CGFloat(cols)
        self.spriteHeight = 1.0/CGFloat(rows)
    }
    
    func setSpriteWidthAndHeight(w : Int, _ h : Int){
        self.spriteWidth = CGFloat(w) / self.sheetTexture.size().width
        self.spriteHeight = CGFloat(h) / self.sheetTexture.size().height
    }
    
    func setMarginAndSpacing(m : Int, _ s : Int){
        self.margin = CGFloat(m) / self.sheetTexture.size().width
        self.spacing = CGFloat(s) / self.sheetTexture.size().width
    }
    
    func setRowsAndCols(){
        self.rows = Int(self.sheetTexture.size().width / self.spriteWidth)
        self.cols = Int(self.sheetTexture.size().height / self.spriteHeight)
    }
    
    func getSprite(x: Int, _ y: Int) -> SKTexture?{
        if x >= cols || y >= rows {
            return nil
        }else{
            let startX = (CGFloat(x) * (spriteWidth + spacing)) + margin
            let startY = (CGFloat(y) * (spriteHeight + spacing)) + margin
            return SKTexture(rect:CGRectMake(startX, startY, spriteWidth, spriteHeight), inTexture:sheetTexture)
        }
    }
    
    func getSprite(id : Int) -> SKTexture? {
        let spriteCount = self.rows * self.cols
        let x = (id - 1) % self.cols
        let y = (spriteCount - id) / self.cols
        
        return self.getSprite(x, y)
    }
}

