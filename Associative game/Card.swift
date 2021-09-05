//
//  Card.swift
//  Associative game
//
//  Created by 大澤清乃 on 2021/07/18.
//

import UIKit

class Card: UIView {
    
    @IBOutlet var label: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.borderWidth = 5
        
    }
}
