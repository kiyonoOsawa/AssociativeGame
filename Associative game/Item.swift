//
//  Item.swift
//  Associative game
//
//  Created by 大澤清乃 on 2021/03/14.
//

import Foundation
import RealmSwift

class Item: Object {
    
    @objc dynamic var id: Int = 0
    @objc dynamic var title: String? = nil
//    let contents = List<Contents> ()
    
    override static func primaryKey() -> String? {
        return "id"
    }
    override static func indexedProperties() -> [String] {
        return ["id", "title"]
    }
    
}

class Contents: Object {
    
    @objc dynamic var title: String? = nil
    @objc dynamic var content: String? = nil
}
