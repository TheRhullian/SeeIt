//
//  Cache.swift
//  SeeIt
//
//  Created by Rhullian Damião on 03/02/22.
//

import Foundation

class Cache {
    static let shared = Cache()
    
    private let appCache = NSCache<NSString, AnyObject>()
    
    func insert(value: AnyObject, key: String) {
        appCache.setObject(value, forKey: NSString(string: key))
    }
    
    func value<T>(for key: String) -> T? {
        return appCache.object(forKey:NSString(string: key)) as? T
    }
    
    func remove(key: String) {
        return appCache.removeObject(forKey: NSString(string: key))
    }
}
