//
//  TabBar.swift
//  Associative game
//
//  Created by 大澤清乃 on 2021/08/07.
//

import UIKit

class TabBar: UITabBar {

    override func sizeThatFits(_ size: CGSize) -> CGSize {
            var sizeThatFits = super.sizeThatFits(size)
            sizeThatFits.height = 145
            return sizeThatFits;
        UITabBar.appearance().backgroundImage = UIImage()
    }
}
