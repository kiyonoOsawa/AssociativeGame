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
        layer.borderWidth = 2
    }

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
