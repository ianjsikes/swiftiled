//
//  Stack.swift
//  SwifTile
//
//  Created by Avelina Kim on 11/9/15.
//  Copyright © 2015 ian. All rights reserved.
//

import Foundation

public class Stack<T> {
    
    private var list : [T] = []
    
    func push(t : T) {
        list.append(t)
    }
    
    func pop() -> T? {
        return list.popLast()
    }
    
    func peek() -> T? {
        return list.last
    }
    
    func size() -> Int {
        return list.count
    }
    
}