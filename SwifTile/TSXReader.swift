//
//  TSXReader.swift
//  SwifTile
//
//  Created by Avelina Kim on 11/9/15.
//  Copyright © 2015 ian. All rights reserved.
//

import Foundation

class TSXReader : NSObject, NSXMLParserDelegate {
    var parser : NSXMLParser = NSXMLParser()
    
    var tileset : TMXTileset = TMXTileset()
    var tagStack : Stack<String> = Stack<String>()
    
    init?(fileName : String, tileset : TMXTileset){
        super.init()
        self.tileset = tileset
        if let path = NSBundle.mainBundle().pathForResource(fileName, ofType: "tsx"){
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
        case "tileset":
            self.tileset.createTileset(attributeDict)
            print("Tileset found")
        case "image":
            if let source = attributeDict["source"] {
                var split = source.componentsSeparatedByString("/")
                var filename = split[split.count - 1]
                split = filename.componentsSeparatedByString(".")
                filename = split[0]
                print("Filename: \(filename)")
                self.tileset.imageName = filename
                self.tileset.setSpriteSheet()
            }
            print("Image found")
//        case "data":
//            let data = TMXData()
//            self.currData = data
//            if let layer = self.currLayer {
//                layer.data = data
//            }
//            data.createData(attributeDict)
//            print("Data found")
        default:
            break
        }
    }
    
    func parser(parser: NSXMLParser, foundCharacters string: String) {
        //print(string)
//        if tagStack.peek() == "data" {
//            if let data = self.currData {
//                data.dataString += string
//            }
//        }
    }
    
    func parser(parser: NSXMLParser,
        didEndElement elementName: String,
        namespaceURI: String?,
        qualifiedName qName: String?)
    {
        tagStack.pop()
//        switch elementName {
//        case "data":
//            currData!.dataString = currData!.dataString.stringByReplacingOccurrencesOfString("\n", withString: "")
//            currData!.processDataString()
            //print("Data string: \(currData!.dataString)")
            //currData!.base64Decode()
//        default:
//            break
//        }
    }
    
}