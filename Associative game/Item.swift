//
//  Item.swift
//  Associative game
//
//  Created by 大澤清乃 on 2021/03/14.
//

import Foundation
import RealmSwift

class Item: Object {
    
    @objc dynamic var id: String = UUID().uuidString
    @objc dynamic var title: String? = nil
    @objc dynamic var timer: Bool = false
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
