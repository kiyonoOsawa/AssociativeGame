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
    var savedItem: Item!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        savetableview.backgroundColor = UIColor(red: 255, green: 252, blue: 242, alpha: 1.0)
        savetableview.tableFooterView = UIView()
        
        do{
            let realm = try Realm()
            itemList = realm.objects(Item.self)
            print("アイテム")
            print(itemList)
            savetableview.reloadData()
        }catch{
        }
        
        print(Realm.Configuration.defaultConfiguration.fileURL!)
        //tableviewの高さを変える
        savetableview.rowHeight = 70
        savetableview.delegate = self
        savetableview.dataSource = self
        // xibを入れる
        savetableview.register(UINib(nibName: "BananaTableViewCell", bundle: nil), forCellReuseIdentifier: "Cell")
        //アイコンの大きさを変える
        for item in (self.tabBarController?.tabBar.items)! {
            item.imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        }
        // 画像と文字の選択時の色を指定（未選択字の色はデフォルトのまま）
        UITabBar.appearance().tintColor = UIColor.init(red: 15/255, green: 37/255, blue: 64/255, alpha: 1.0)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //データの取得
        self.itemList = realm.objects(Item.self)
        self.contentList = realm.objects(Contents.self)
        savetableview.reloadData()
        //navigationBarを透明にする
        self.navigationController!.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController!.navigationBar.shadowImage = UIImage()
    }
    // セルの編集許可
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == UITableViewCell.EditingStyle.delete {
            do{
                let realm = try! Realm()
                //削除したいデータを取得
                let item = itemList[indexPath.row]
                //ContentsとMatchingPairは別のクラスなので取得し直す必要がある
                let contents = realm.objects(Contents.self).filter("title == %@", item.title)
                let matchingPair = realm.objects(MatchingPair.self).filter("title == %@", item.title)
                try! realm.write {
                    //MatchingPairを削除
                    realm.delete(matchingPair)
                    //Contentsを削除
                    realm.delete(contents)
                    //Itemを削除
                    realm.delete(item)
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
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! BananaTableViewCell
        let object = itemList[indexPath.row]
        cell.titletextLabel.text = itemList[indexPath.row].title
        //>マーク
        cell.accessoryType = UITableViewCell.AccessoryType.disclosureIndicator
        cell.accessoryView?.backgroundColor = UIColor(red: 255, green: 252, blue: 242, alpha: 1.0)
        let icon = UIImage(data: itemList[indexPath.row].icon ?? Data())
        cell.iconimageView.image = icon
        print(itemList[indexPath.row].title)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if itemList[indexPath.row].timer == true {
            let vc = storyboard.instantiateViewController(identifier: "gameVC") as! GameViewController
            if itemList.count != 0 {
                savedItem = itemList[indexPath.row]
                print("タイトル\(savedItem!)")
                print("タイトル\(itemList[indexPath.row].title)")
                vc.savedItem = itemList[indexPath.row]
                self.navigationController?.pushViewController(vc, animated: true)
            }
        } else {
            let vc = storyboard.instantiateViewController(identifier: "addVC") as! AddViewController
            if itemList.count != 0 {
                savedItem = itemList[indexPath.row]
                print("タイトル\(savedItem!)")
                print("タイトル\(itemList[indexPath.row].title)")
                vc.savedItem = itemList[indexPath.row]
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
        tableView.deselectRow(at: indexPath as IndexPath, animated: true)
    }
    
}
