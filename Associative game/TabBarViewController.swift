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
        
        // 背景の透過
        UITabBar.appearance().backgroundImage = UIImage()
        // 境界線の透過
        UITabBar.appearance().shadowImage = UIImage()
        UITabBar.appearance().layer.borderWidth = 0.50
        UITabBar.appearance().clipsToBounds = true
        // Do any additional setup after loading the view.
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
