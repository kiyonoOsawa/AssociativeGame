//
//  AddViewController.swift
//  Associative game
//
//  Created by 大澤清乃 on 2021/09/18.
//

import UIKit
import RealmSwift

class AddViewController: UIViewController {
    
    @IBOutlet weak var beforeLabel: UILabel!
    @IBOutlet weak var addTextField: UITextField!
    @IBOutlet weak var saveButton: UIButton!
    var listButtonItem: UIBarButtonItem!
    var backButtonItem: UIBarButtonItem!
    var savedItem: Item!
    var content: Results<Contents>!
    let realm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController!.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController!.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.tintColor = UIColor.black
        self.navigationItem.title = savedItem.title
        listButtonItem = UIBarButtonItem(title:"List", style: .done, target: self, action: #selector(taplistButton))
        self.navigationItem.rightBarButtonItem = listButtonItem
        if savedItem.contents.isEmpty {
            beforeLabel.text = savedItem.title
        } else {
            beforeLabel.text = savedItem.contents.last?.content
        }
        let realm = try! Realm()
        let tapCG: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapCG.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tapCG)
        addTextField.becomeFirstResponder()
        designImage()
        
    }
    
    func designImage() {
        saveButton.layer.shadowOpacity = 0.2
        saveButton.layer.shadowColor = UIColor.black.cgColor
        saveButton.layer.shadowOffset = CGSize(width: 0, height: 0)
        saveButton.layer.masksToBounds = false
        saveButton.layer.cornerRadius = 15
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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if savedItem.contents.isEmpty {
            beforeLabel.text = savedItem.title
        } else {
            beforeLabel.text = savedItem.contents.last?.content
        }
        let results = realm.objects(Item.self)
        self.content = realm.objects(Contents.self).filter("title == '\(self.savedItem.title!)'")
        
    }
    
    @objc func dismissKeyboard() {
        self.view.endEditing(true)
    }
    
    @objc func taplistButton() {
        let vc = storyboard?.instantiateViewController(identifier: "addListVC") as! AddListViewController
        vc.savedItem = savedItem
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func tapsaveButton(_ sender: Any) {
        let contents = Contents()
        contents.itemId = self.savedItem.id
        contents.title = self.savedItem.title
        contents.content = addTextField.text!
        if contents.content == "" {
            return
        } else {
            contents.content = addTextField.text!
            beforeLabel.text = contents.content
        }
        do {
            let realm = try!Realm()
            try realm.write({ () -> Void in
                self.savedItem.contents.append(contents)
            })
        } catch {
            print("Save is Faild")
        }
        addTextField.text = ""
        addTextField.becomeFirstResponder()
    }
}
