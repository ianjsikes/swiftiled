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
        setMarginAndSpacing(margin, spacing)
        setRowsAndCols()
    }
    
    func setSpriteWidthAndHeight(){
        self.spriteWidth = 1.0/CGFloat(cols)
        self.spriteHeight = 1.0/CGFloat(rows)
    }
    
    func setSpriteWidthAndHeight(w : Int, _ h : Int){
//        print(w, h)
//        self.spriteWidth = CGFloat(w) / self.sheetTexture.size().width
//        self.spriteHeight = CGFloat(h) / self.sheetTexture.size().height
        self.spriteWidth = CGFloat(w)
        self.spriteHeight = CGFloat(h)
    }
    
    func setMarginAndSpacing(m : Int, _ s : Int){
//        self.margin = CGFloat(m) / self.sheetTexture.size().width
//        self.spacing = CGFloat(s) / self.sheetTexture.size().width
        self.margin = CGFloat(m)
        self.spacing = CGFloat(s)
        print("Margin: \(self.margin), Spacing: \(self.spacing)")
    }
    
    func setRowsAndCols(){
        print("Width: \(self.sheetTexture.size().width), Sprite Width: \(self.spriteWidth)")
        print("Height: \(self.sheetTexture.size().height), Sprite Height: \(self.spriteHeight)")
        self.rows = Int((self.sheetTexture.size().width - (self.margin)) / (self.spriteWidth + self.spacing))
        self.cols = Int((self.sheetTexture.size().height - (self.margin)) / (self.spriteHeight + self.spacing))
        print("Rows: \(self.rows), Cols: \(self.cols)")
    }
    
    func getSprite(x: Int, _ y: Int) -> SKTexture?{
        if x >= cols || y >= rows {
            return nil
        }else{
            let startX = (CGFloat(x) * (spriteWidth + spacing)) + margin
            let startY = (CGFloat(y) * (spriteHeight + spacing)) + margin
            
            let percentX = startX / self.sheetTexture.size().width
            let percentY = startY / self.sheetTexture.size().height
            print("StartX: \(startX), StartY: \(startY)")
            return SKTexture(rect:CGRectMake(percentX, percentY, (spriteWidth / self.sheetTexture.size().width), (spriteHeight / self.sheetTexture.size().height)), inTexture:sheetTexture)
        }
    }
    
    func getSprite(id : Int) -> SKTexture? {
        //print("Rows: \(self.rows), Cols: \(self.cols)")
        let spriteCount = self.rows * self.cols
//        print("Sprite Count: \(spriteCount)")
        let x = (id - 1) % self.cols
        let y = (spriteCount - id) / self.cols
        
//        print("Getting sprite - ID: \(id), Coordinates: (\(x), \(y))")
        
        return self.getSprite(x, y)
    }
}

