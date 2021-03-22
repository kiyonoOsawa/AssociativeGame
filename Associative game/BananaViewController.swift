//
//  BananaViewController.swift
//  Associative game
//
//  Created by 大澤清乃 on 2021/02/01.
//

import UIKit
import RealmSwift

class BananaViewController: UIViewController,UITableViewDataSource,UITextFieldDelegate {
    
    @IBOutlet var newbutton: UIButton!
    @IBOutlet var savetableview: UITableView!
    var itemList: Results<Item>!
    var maxId: Int{return try!Realm().objects(Item.self).sorted(byKeyPath: "id").last?.id ?? 0}
    let realm = try! Realm()
    
    @IBAction func aleat(_ sender: Any) {
        
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .alert)
        let textField = UITextField()
        alert.title = "新規作成"
        alert.message = "タイトルを入力"
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
                    //textfieldでItemを保存
                    if alert.textFields![0].text != "" {
                        let item = Item()
                        item.title = alert.textFields![0].text
                        item.id = self.maxId + 1
                        let realm = try! Realm()
                        
                        try! realm.write {
                            realm.add(item)
                        }
                        self.itemList = realm.objects(Item.self)
                        self.savetableview.reloadData()
                    }
                })
        )
        //キャンセルボタン
        alert.addAction(
            UIAlertAction(
                title: "キャンセル",
                style: .cancel,
                handler: {(action) -> Void in
                    self.hello(action.title!)
                })
        )
        //アラートが表示されるごとにprint
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(Realm.Configuration.defaultConfiguration.fileURL!)
        //tableviewの高さを変える
        savetableview.rowHeight = 90
        savetableview.dataSource = self
        //アイコンの大きさを変える
        for item in (self.tabBarController?.tabBar.items)! {
            item.imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        }
        // 画像と文字の選択時の色を指定（未選択字の色はデフォルトのまま）
        UITabBar.appearance().tintColor = UIColor.init(red: 8/255, green: 25/255, blue: 45/255, alpha: 100/100)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //データの取得
        self.itemList = realm.objects(Item.self)
        savetableview.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
        
        cell?.textLabel?.text = itemList[indexPath.row].title
        
        return cell!
    }
    
    func tableview(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "addVC") as! AddViewController
        if itemList.count != 0 {
            self.navigationController?.pushViewController(vc, animated: true)
        }
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
