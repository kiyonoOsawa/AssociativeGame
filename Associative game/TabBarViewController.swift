//
//  TabBarViewController.swift
//  Associative game
//
//  Created by 大澤清乃 on 2021/02/14.
//

import UIKit

class TabBarViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 境界線の透過
        UITabBar.appearance().shadowImage = UIImage()
        UITabBar.appearance().layer.borderWidth = 0.50
        UITabBar.appearance().clipsToBounds = true
        UITabBar.appearance().backgroundColor = UIColor(named: "BackColor")
        UITabBar.appearance().barTintColor = UIColor(named: "BackColor")
        UITabBarItem.appearance().setTitleTextAttributes( [.foregroundColor : UIColor.black
        ],for: .selected)
    }
}
