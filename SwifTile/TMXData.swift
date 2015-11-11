//
//  TMXData.swift
//  SwifTile
//
//  Created by Avelina Kim on 11/8/15.
//  Copyright © 2015 ian. All rights reserved.
//

import Foundation



class TMXData : NSObject {
    
    var encoding : Encoding = .xml
    var compression : Compression = .none
    
    var tmxTiles : [TMXTile]?
    var dataString : String = ""
    var gids : [Int] = []
    
    override var description : String {
        return "\n\t\t\tDATA:\n\t\t\tEncoding: \(self.encoding),\n\t\t\tCompression: \(self.compression),\n\t\t\tGIDs: \(gids)"
    }
    
    
    
    
    func createData(attributes : [String : String]) {
        
        if let enc = attributes["encoding"] {
            if let encoding = TMXData.Encoding(rawValue: enc) {
                self.encoding = encoding
            }
        }
        if let comp = attributes["compression"] {
            if let compression = TMXData.Compression(rawValue: comp) {
                self.compression = compression
            }
        }
    }
    
    func processDataString() {
        if encoding == .csv {
            processCSVData()
        } else {
            print("WARNING: base64 encoding is not currently supported. Please save your map with csv encoding")
        }
    }
    
    func processCSVData() {
        let arr = dataString.componentsSeparatedByString(",")
        gids = arr.map({str in (str as NSString).integerValue})
    }
    
    func base64Decode() {
//        if let decodedData = NSData(base64EncodedString: dataString, options: NSDataBase64DecodingOptions(rawValue: 0)) {
//            print("Data decoded")
//            if let decodedString = NSString(data: decodedData, encoding: NSUTF8StringEncoding) {
//                print("String decoded")
//                print(decodedString)
//            }
//        }
        //print(dataString.base64Decoded())
    }
    
    enum Encoding : String {
        case base64
        case csv
        case xml
    }
    
    enum Compression : String {
        case none
        case gzip
        case zlib
    }
}

extension String {
    
    func base64Encoded() -> String {
        let plainData = dataUsingEncoding(NSUTF8StringEncoding)
        let base64String = plainData?.base64EncodedStringWithOptions(NSDataBase64EncodingOptions(rawValue: 0))
        return base64String!
    }
    
    func base64Decoded() -> String {
        let decodedData = NSData(base64EncodedString: self, options:NSDataBase64DecodingOptions(rawValue: 0))
        let decodedString = NSString(data: decodedData!, encoding: NSUTF8StringEncoding)
        return decodedString! as String
    }
}






