//
//  TMXLayer.swift
//  SwifTile
//
//  Created by Avelina Kim on 11/8/15.
//  Copyright © 2015 ian. All rights reserved.
//

import Foundation

class TMXLayer: NSObject {
    var layerName : String = ""
    var x : Int = 0
    var y : Int = 0
    var width : Int = 0
    var height : Int = 0
    var opacity : Double = 1.0
    var visible : Bool = true
    var offset : (Int, Int) = (0, 0)
    var data : TMXData?
    
    override var description : String {
        return "\n\t\tLAYER: \(layerName),\n\t\tWidth: \(width),\n\t\tHeight: \(height),\n\t\tOpacity: \(opacity),\n\t\tVisible: \(visible),\n\t\tOffset: \(offset)\n\t\tData: \(data)"
    }
    
    init(layerName : String, width : Int, height : Int, data : TMXData) {
        self.layerName = layerName
        self.width = width
        self.height = height
        self.data = data
    }
    
    override init() {
        super.init()
    }
    
//    func getGID(x: Int, _ y: Int) -> Int {
//        let index = (y * width) + x
//        return data!.gids[index]
//    }
//    
//    func getCoords(index : Int) -> (Int, Int) {
//        let x = index % width
//        let y = index / width
//        return (x, y)
//    }
    
    func createLayer(attributes : [String : String]) {
        
        if let layerName = attributes["name"] {
            self.layerName = layerName
        }
        if let width = attributes["width"] {
            self.width = (width as NSString).integerValue
        }
        if let height = attributes["height"] {
            self.height = (height as NSString).integerValue
        }
        if let x = attributes["x"] {
            self.x = (x as NSString).integerValue
        }
        if let y = attributes["y"] {
            self.y = (y as NSString).integerValue
        }
        if let opacity = attributes["opacity"] {
            self.opacity = (opacity as NSString).doubleValue
        }
        if let visible = attributes["visible"] {
            self.visible = (visible as NSString).boolValue
        }
    }
    
    
}