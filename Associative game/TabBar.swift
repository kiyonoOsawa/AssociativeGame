//
//  TabBar.swift
//  Associative game
//
//  Created by 大澤清乃 on 2021/02/14.
//

import UIKit

class TabBar: UITabBar {
    
    //tabbarの高さをかえる
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        var sizeThatFits = super.sizeThatFits(size)
        sizeThatFits.height = 180
        return sizeThatFits;
    }
}

