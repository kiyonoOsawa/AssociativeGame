//
//  AddViewController.swift
//  Associative game
//
//  Created by 大澤清乃 on 2021/09/18.
//

import UIKit
import RealmSwift

class AddViewController: UIViewController {
    
    @IBOutlet var beforeLabel: UILabel!
    @IBOutlet var addTextField: UITextField!
    @IBOutlet var saveButton: UIButton!
    var listButtonItem: UIBarButtonItem!
    var savedItem: Item!
    var content: Results<Contents>!
    let realm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController!.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController!.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.tintColor = UIColor.black
        let border = CALayer()
        let width = CGFloat(2.0)
        border.borderColor = UIColor.black.cgColor
        border.frame = CGRect(x: 0, y: addTextField.frame.size.height - width, width: addTextField.frame.size.width, height: 1)
        border.borderWidth = width
        addTextField.placeholder = " Word"
        addTextField.layer.addSublayer(border)
        beforeLabel.layer.cornerRadius = 15
        beforeLabel.layer.borderColor = UIColor.black.cgColor
        beforeLabel.layer.borderWidth = 1
        self.navigationItem.title = savedItem.title
        listButtonItem = UIBarButtonItem(title:"List", style: .done, target: self, action: #selector(taplistButton))
        self.navigationItem.rightBarButtonItem = listButtonItem
        let results = realm.objects(Item.self)
        self .content = realm.objects(Contents.self).filter("title == '\(self.savedItem.title)'")
        let realm = try! Realm()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let results = realm.objects(Item.self)
        self.content = realm.objects(Contents.self).filter("title == '\(self.savedItem.title!)'")
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // キーボードを閉じる
        addTextField.resignFirstResponder()
        return true
    }
    
    @objc func taplistButton() {
        let vc = storyboard?.instantiateViewController(identifier: "addListVC") as! AddListViewController
        vc.savedItem = savedItem
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func tapsaveButton(_ sender: Any) {
        self.presentingViewController?.dismiss(animated: true, completion: nil)
        let contents = Contents()
//        contents.title = self.savedItem.title
        contents.content = addTextField.text!
        beforeLabel.text = contents.content
        if contents.content == "" {
            contents.content != self.savedItem.title
        } else {
            contents.title = self.savedItem.title
        }
        do {
            let realm = try!Realm()
            try realm.write({ () -> Void in
                realm.add(contents)
            })
        } catch {
            print("Save is Faild")
        }
    }
}
