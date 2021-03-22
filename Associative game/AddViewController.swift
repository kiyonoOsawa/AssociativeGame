//
//  AddViewController.swift
//  Associative game
//
//  Created by 大澤清乃 on 2021/03/06.
//

import UIKit
import RealmSwift

class AddViewController: UIViewController,UITableViewDataSource,UITextFieldDelegate {
    
    @IBOutlet var addtableview: UITableView!
    var contentList: Results<Item>!
    let realm = try! Realm()
    
    @IBAction func backbutton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func aleat(_ sender: Any) {
        
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .alert)
        alert.title = "入力"
        alert.message = "追加"
        alert.addTextField(configurationHandler: {(textField) -> Void in
            textField.delegate = self
        })
        //追加ボタン
        alert.addAction(
            UIAlertAction(
                title: "追加",
                style: .default,
                handler: {(action) -> Void in
                    self.hello(action.title!)
                    //textfieldを保存
                    if alert.textFields![0].text != ""{
                        let item = Item()
                        item.contentList = alert.textFields![0].text
                        let realm = try! Realm()
                        
                        try! realm.write {
                            realm.add(item)
                        }
                        self.contentList = realm.objects(Item.self)
                        self.addtableview.reloadData()
                    }
                })
        )
        alert.addAction(
            UIAlertAction(
                title: "キャンセル",
                style: .cancel,
                handler: {(action) -> Void in
                    self.hello(action.title!)
                })
        )
        self.present(
            alert,
            animated: true,
            completion: {
                print("アラートが表示された")
            })
    }
    func hello(_ msg:String){
        print(msg)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //データの取得
        self.contentList = realm.objects(Item.self)
        addtableview.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contentList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
        
        cell?.textLabel?.text = contentList[indexPath.row].contentList
        
        return cell!
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addtableview.rowHeight = 90
        addtableview.dataSource = self
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
