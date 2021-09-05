//
//  BookMarkViewController.swift
//  Associative game
//
//  Created by 大澤清乃 on 2021/08/01.
//

import UIKit
import RealmSwift

class BookMarkViewController: UIViewController, UITableViewDataSource,UITableViewDelegate {
    
    @IBOutlet var favoritetableview: UITableView!
    var favoriteArray: [MatchingPair] = []
    let realm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        favoritetableview.rowHeight = 70
        favoritetableview.dataSource = self
        favoritetableview.delegate = self
        self.navigationController?.navigationBar.tintColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 1.0)
        self.navigationController?.navigationBar.titleTextAttributes = [
            .foregroundColor: UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 1.0)]
        favoritetableview.register(UINib(nibName: "BookMarkTableViewCell", bundle: nil), forCellReuseIdentifier: "Cell")
        favoritetableview.backgroundColor = UIColor(named: "BackColor")
        favoritetableview.tableFooterView = UIView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //データの取得
        //全てのデータを取得
        self.favoriteArray = Array(realm.objects(MatchingPair.self).filter("IsFavorite == true"))
        //for文を使ってIsFavoriteがtrueでなはないMatchingPairを配列から削除する
        for index in 0 ..< favoriteArray.count {
            let matchingPair = favoriteArray[index]
            //もしIsFavoriteがtrueでなければ
            if !matchingPair.IsFavorite {
                //配列から削除する
                favoriteArray.remove(at: index)
            }
            favoritetableview.reloadData()
        }
        print(favoriteArray)
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectMatchingPair = favoriteArray[indexPath.row]
        if selectMatchingPair.IsFavorite == true {
            // realmの元のデータを書き換えるからrealm.writeで囲む
            try! realm.write {
                selectMatchingPair.IsFavorite = false
            }
        }else{
        }
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoriteArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! BookMarkTableViewCell
        cell.datatextLabel.text = favoriteArray[indexPath.row].pair1!
        cell.ideatextLabel.text = favoriteArray[indexPath.row].pair2
        let selectMatchingPair = favoriteArray[indexPath.row]
        //セルの選択状態
        cell.selectionStyle = .none
        if selectMatchingPair.IsFavorite == true {
            cell.starImage.image = UIImage(named: "star")
        } else {
            cell.starImage.image = UIImage(named: "borderstar")
        }
        return cell
    }
}
