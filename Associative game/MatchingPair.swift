//
//  MatchingPair.swift
//  Associative game
//
//  Created by 大澤清乃 on 2021/08/01.
//

import Foundation
import RealmSwift

class MatchingPair: Object {
    
    @objc dynamic var title: String? = nil
    @objc dynamic var pair1: String? = nil // ランダムに選択したコンテンツ
    @objc dynamic var pair2: String? = nil // ピッカーから選択したコンテンツ
    @objc dynamic var IsFavorite: Bool = false // falseのときBookMarkに表示
}
