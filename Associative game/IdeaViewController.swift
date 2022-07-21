//
//  IdeaViewController.swift
//  Associative game
//
//  Created by 大澤清乃 on 2021/02/01.
//

import UIKit

class IdeaViewController: UIViewController {
    
    @IBOutlet var buttonImage: [UIButton]!
    @IBOutlet var bookmark: UIButton!
    @IBOutlet var matching: UIButton!
    @IBOutlet var matchinglist: UIButton!
    @IBOutlet var list: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageDesign()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController!.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController!.navigationBar.shadowImage = UIImage()
    }
    
    func imageDesign() {
        for buttonImage in buttonImage {
            buttonImage.layer.shadowOpacity = 0.4
            buttonImage.layer.shadowRadius = 3.5
            buttonImage.layer.shadowColor = UIColor.black.cgColor
            buttonImage.layer.shadowOffset = CGSize(width: 0, height: 0)
        }
    }
}
