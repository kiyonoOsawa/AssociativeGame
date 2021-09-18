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
        //navigationBarを透明にする
        self.navigationController!.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController!.navigationBar.shadowImage = UIImage()
        // 画像と文字の選択時の色を指定（未選択字の色はデフォルトのまま）
        UITabBar.appearance().tintColor = UIColor.init(red: 15/255, green: 37/255, blue: 64/255, alpha: 1.0)
        //アイコンの大きさを変える
        for item in (self.tabBarController?.tabBar.items)! {
            item.imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        }
        savetableview.rowHeight = 70
        // xibを入れる
        savetableview.register(UINib(nibName: "BananaTableViewCell", bundle: nil), forCellReuseIdentifier: "Cell")
        savetableview.backgroundColor = UIColor(named: "BackColor")
        savetableview.tableFooterView = UIView()
        savetableview.delegate = self
        savetableview.dataSource = self
        do{
            let realm = try Realm()
            itemList = realm.objects(Item.self)
            print("アイテム")
            print(itemList)
            savetableview.reloadData()
        }catch{
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //データの取得
        self.itemList = realm.objects(Item.self)
        self.contentList = realm.objects(Contents.self)
        savetableview.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! BananaTableViewCell
        let object = itemList[indexPath.row]
        // セルの選択状態
        cell.selectionStyle = .none
        cell.titletextLabel.text = itemList[indexPath.row].title
        // >マーク
        cell.accessoryType = UITableViewCell.AccessoryType.disclosureIndicator
        // icon
        let icon = UIImage(data: itemList[indexPath.row].icon ?? Data())
        cell.iconImageView.image = icon
        cell.backgroundColor = UIColor(named: "BackColor")
        print(itemList[indexPath.row].title)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Main.Storyboardの取得
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        // 選択したitemの取得
        let item = itemList[indexPath.row]
        // StartViewControllerの生成
        let startViewController = storyboard.instantiateViewController(identifier: "startVC") as! StartViewController
        // 値渡しを行う
        startViewController.selectedItem = item
        // 画面遷移をする
        navigationController?.pushViewController(startViewController, animated: true)
    }
    
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
                    realm.delete(matchingPair)
                    realm.delete(contents)
                    realm.delete(item)
                }
                tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.fade)
            }catch{
            }
            tableView.reloadData()
        }
    }
}
