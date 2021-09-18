//
//  IdeaViewController.swift
//  Associative game
//
//  Created by 大澤清乃 on 2021/02/01.
//

import UIKit

class IdeaViewController: UIViewController {
    
    @IBOutlet var bookmark: UIButton!
    @IBOutlet var matching: UIButton!
    @IBOutlet var matchinglist: UIButton!
    @IBOutlet var list: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UITabBar.appearance().tintColor = UIColor.init(red: 0/255, green: 0/255, blue: 0/255, alpha: 1.0)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController!.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController!.navigationBar.shadowImage = UIImage()
    }
}
