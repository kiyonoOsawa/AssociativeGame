//
//  BananaViewController.swift
//  Associative game
//
//  Created by 大澤清乃 on 2021/02/01.
//

import UIKit
import RealmSwift

class BananaViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate {
    
    @IBOutlet var newbutton: UIButton!
    @IBOutlet var savetableview: UITableView!
    var itemList: Results<Item>!
    var contentList: Results<Contents>!
    var maxId: String{return try!Realm().objects(Item.self).sorted(byKeyPath: "id").last?.id ?? ""}
    let realm = try! Realm()
    var savedTitle: String!
    
    //    @IBAction func aleat(_ sender: Any) {
    //        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .alert)
    //        let textField = UITextField()
    //        alert.title = "新規作成"
    //        alert.message = "タイトルを入力"
    //        alert.addTextField(configurationHandler: {(textField) -> Void in
    //            textField.delegate = self
    //
    //        })
    //
    //        //追加ボタン
    //        alert.addAction(
    //            UIAlertAction(
    //                title: "追加",
    //                style: .default,
    //                handler: {(action) -> Void in
    //                    self.hello(action.title!)
    //                    //textfieldでItemを保存
    //                    if alert.textFields![0].text != "" {
    //                        let item = Item()
    //                        item.title = alert.textFields![0].text
    //                        item.id = self.maxId + 1
    //                        let realm = try! Realm()
    //
    //                        try! realm.write {
    //                            realm.add(item)
    //                        }
    //                        self.itemList = realm.objects(Item.self)
    //                        self.savetableview.reloadData()
    //                    }
    //                })
    //        )
    //        //キャンセルボタン
    //        alert.addAction(
    //            UIAlertAction(
    //                title: "キャンセル",
    //                style: .cancel,
    //                handler: {(action) -> Void in
    //                    self.hello(action.title!)
    //                })
    //        )
    //        //アラートが表示されるごとにprint
    //        self.present(
    //            alert,
    //            animated: true,
    //            completion: {
    //                print("アラートが表示された")
    //            })
    //    }
    //
    //    func hello(_ msg:String){
    //        print(msg)
    //    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        do{
            let realm = try Realm()
            itemList = realm.objects(Item.self)
            savetableview.reloadData()
        }catch{
            
        }
        
        print(Realm.Configuration.defaultConfiguration.fileURL!)
        //tableviewの高さを変える
        savetableview.rowHeight = 90
        savetableview.delegate = self
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
        self.contentList = realm.objects(Contents.self)
        savetableview.reloadData()
    }
    // セルの編集許可
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == UITableViewCell.EditingStyle.delete {
            do{
                let realm = try! Realm()
                try! realm.write {
                    realm.delete(self.itemList[indexPath.row])
                }
                tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.fade)
            }catch{
            }
            tableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
        let object = itemList[indexPath.row]
        cell?.textLabel?.text = itemList[indexPath.row].title
        print(itemList[indexPath.row].title)
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "addVC") as! AddViewController
        if itemList.count != 0 {
            savedTitle = itemList[indexPath.row].title!
            print("タイトル\(savedTitle!)")
            print("タイトル\(itemList[indexPath.row].title)")
            vc.savedTitle = itemList[indexPath.row].title!
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    //    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    //        if segue.identifier == "showAddSegue" {
    //            let storyboard = UIStoryboard(name: "Main", bundle: nil)
    //            let vc = storyboard.instantiateViewController(identifier: "addVC") as! AddViewController
    //            vc.savedTitle = savedTitle!
    //            print("vc: \(vc.savedTitle)")
    //        }
    //
    //    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
