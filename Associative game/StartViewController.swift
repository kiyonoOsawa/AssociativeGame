//
//  StartViewController.swift
//  Associative game
//
//  Created by 大澤清乃 on 2021/09/18.
//

import UIKit
import RealmSwift

class StartViewController: UIViewController {
    
    @IBOutlet var listButton: UIButton!
    @IBOutlet var starButton: UIButton!
    var selectedItem: Item!
    var savedItem: Item!
    var itemList: Results<Item>!
    let realm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController!.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController!.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.tintColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 1.0)
        let results = realm.objects(Item.self)
        let realm = try! Realm()
    }
    
    @IBAction func tapStartButton() {
        if selectedItem.timer == true {
            let vc = storyboard?.instantiateViewController(identifier: "gameVC") as! GameViewController
            vc.savedItem = selectedItem
            self.navigationController?.pushViewController(vc, animated: true)
        } else {
            let vc = storyboard?.instantiateViewController(identifier: "addVC") as! AddViewController
            vc.savedItem = selectedItem
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
