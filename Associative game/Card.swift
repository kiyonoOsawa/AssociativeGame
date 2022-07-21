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
        //        // 影のずれを設定
        //        layer.shadowOffset = CGSize(width: 0, height: 2)
        //        // 影の不透明度を設定（0~1の範囲で大きいほど影が濃い）
        //        layer.shadowOpacity = 0.4
        //        // 影の色を設定
        //        layer.shadowColor = UIColor.gray.cgColor
        //        
        //        // 枠線をつけている
        //        layer.borderWidth = 2
        let border = CALayer()
        let width = CGFloat(2.0)
        border.borderColor = UIColor.black.cgColor
        border.frame = CGRect(x: 0, y: label.frame.size.height - width, width: label.frame.size.width, height: 1)
        border.borderWidth = width
        layer.addSublayer(border)
    }
}
