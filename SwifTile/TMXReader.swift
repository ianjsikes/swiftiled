//
//  TMXReader.swift
//  SwifTile
//
//  Created by Avelina Kim on 10/27/15.
//  Copyright © 2015 ian. All rights reserved.
//

import Foundation

class TMXReader : NSObject, NSXMLParserDelegate {
    var parser : NSXMLParser = NSXMLParser()
    
    var map : TMXMap = TMXMap()
    var tagStack : Stack<String> = Stack<String>()
    
    var currLayer : TMXLayer?
    var currData : TMXData?
    var currTileset : TMXTileset?
    var currTile : TMXTile?
    
    var delegate : TMXReaderDelegate?
    
    
    init?(fileName : String, delegate : TMXReaderDelegate?){
        self.delegate = delegate
        super.init()
        if let path = NSBundle.mainBundle().pathForResource(fileName, ofType: "tmx"){
            if let tempParser = NSXMLParser(contentsOfURL: NSURL(fileURLWithPath: path)) {
                self.parser = tempParser
            } else {
                return nil
            }
        } else {
            return nil
        }
    }
    
    func beginParsing() {
        parser.delegate = self
        parser.parse()
    }
    
    func parser(parser: NSXMLParser,
        didStartElement elementName: String,
        namespaceURI: String?,
        qualifiedName qName: String?,
        attributes attributeDict: [String : String])
    {
        tagStack.push(elementName)
        //print("<\(elementName) \(attributeDict)>")
        
        switch elementName {
        case "map":
            self.map.createMap(attributeDict)
            //print("Map found")
        case "tileset":
            let tileset = TMXTileset()
            self.map.tilesets.append(tileset)
            self.currTileset = tileset
            tileset.createTileset(attributeDict)
            //print("Tileset found")
        case "tile":
            if let set = self.currTileset {
                let tile = TMXTile()
                self.currTile = tile
                tile.createTile(attributeDict)
                set.tiles.append(tile)
            }
        case "property":
            if let tile = self.currTile {
                tile.addProperty(attributeDict)
            }
        case "image":
            if let source = attributeDict["source"] {
                var split = source.componentsSeparatedByString("/")
                var filename = split[split.count - 1]
                split = filename.componentsSeparatedByString(".")
                filename = split[0]
                print("Filename: \(filename)")
                self.currTileset!.imageName = filename
                self.currTileset!.setSpriteSheet()
            }
            //print("Image found")
        case "layer":
            let layer = TMXLayer()
            self.currLayer = layer
            layer.createLayer(attributeDict)
            self.map.layers.append(layer)
            //print("Layer found")
        case "data":
            let data = TMXData()
            self.currData = data
            if let layer = self.currLayer {
                layer.data = data
            }
            data.createData(attributeDict)
            //print("Data found")
        default:
            break
        }
    }
    
    func parser(parser: NSXMLParser, foundCharacters string: String) {
        //print(string)
        if tagStack.peek() == "data" {
            if let data = self.currData {
                data.dataString += string
            }
        }
    }
    
    func parser(parser: NSXMLParser,
        didEndElement elementName: String,
        namespaceURI: String?,
        qualifiedName qName: String?)
    {
        tagStack.pop()
        switch elementName {
        case "tile":
            self.currTile = nil
        case "layer":
            self.currLayer = nil
        case "tileset":
            self.currTileset = nil
        case "data":
            currData!.dataString = currData!.dataString.stringByReplacingOccurrencesOfString("\n", withString: "")
            currData!.processDataString()
            //print("Data string: \(currData!.dataString)")
            //currData!.base64Decode()
        default:
            break
        }
    }
    
    func parserDidEndDocument(parser: NSXMLParser) {
        print("Finished reading TMX File")
        self.delegate?.onReaderCompleted(self.map)
        //print(self.map)
    }
    
}








