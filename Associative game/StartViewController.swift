//
//  StartViewController.swift
//  Associative game
//
//  Created by 大澤清乃 on 2021/09/18.
//

import UIKit
import RealmSwift

class StartViewController: UIViewController {
    
    @IBOutlet weak var listButton: UIButton!
    @IBOutlet weak var starButton: UIButton!
    var selectedItem: Item!
    var savedItem: Item!
    var itemList: Results<Item>!
    let realm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController!.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController!.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.tintColor = UIColor.black
        self.navigationItem.title = selectedItem.title
        let results = realm.objects(Item.self)
        self.itemList = realm.objects(Item.self).filter("title == '\(self.selectedItem.title)'")
        let realm = try! Realm()
        designImage()
    }
    
    func designImage() {
        listButton.layer.cornerRadius = 15
        listButton.layer.shadowOpacity = 0.5
        listButton.layer.shadowColor = UIColor.black.cgColor
        listButton.layer.shadowOffset = CGSize(width: 0, height: 0)
        listButton.layer.masksToBounds = false
        starButton.layer.cornerRadius = 15
        starButton.layer.shadowOpacity = 0.5
        starButton.layer.shadowColor = UIColor.black.cgColor
        starButton.layer.shadowOffset = CGSize(width: 0, height: 0)
        starButton.layer.masksToBounds = false
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
    
    @IBAction func tapListButton() {
        if selectedItem.timer == true {
            let vc = storyboard?.instantiateViewController(identifier: "gameListVC") as! GameListViewController
            vc.savedItem = selectedItem
            self.navigationController?.pushViewController(vc, animated: true)
        } else {
            let vc = storyboard?.instantiateViewController(identifier: "addListVC") as! AddListViewController
            vc.savedItem = selectedItem
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
