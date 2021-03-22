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
    @objc dynamic var contentList: String? = nil
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
