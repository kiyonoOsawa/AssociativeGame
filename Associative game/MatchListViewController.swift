//
//  MatchListViewController.swift
//  Associative game
//
//  Created by 大澤清乃 on 2021/08/07.
//

import UIKit
import RealmSwift

class MatchListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var matchlisttableview: UITableView!
    var matchlist: [MatchingPair] = []
    let realm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.tintColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 1.0)
//        self.navigationController?.navigationBar.titleTextAttributes = [
//            .foregroundColor: UIColor(red: 15/255, green: 37/255, blue: 64/255, alpha: 1.0)]
        matchlisttableview.register(UINib(nibName: "BookMarkTableViewCell", bundle: nil), forCellReuseIdentifier: "Cell")
        
        matchlisttableview.rowHeight = 70
        matchlisttableview.delegate = self
        matchlisttableview.dataSource = self
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //データの取得
        self.matchlist = Array(realm.objects(MatchingPair.self))
        print(matchlist)
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return matchlist.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! BookMarkTableViewCell
        cell.datatextLabel.text = matchlist[indexPath.row].pair1!
        cell.ideatextLabel.text = matchlist[indexPath.row].pair2
        let selectMatchingPair = matchlist[indexPath.row]
        if selectMatchingPair.IsFavorite == true {
            cell.starImage.image = UIImage(named: "star")
        } else {
            cell.starImage.image = UIImage(named: "borderstar")
        }
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectMatchingPair = matchlist[indexPath.row]
        if selectMatchingPair.IsFavorite == false {
            // realmの元のデータを書き換えるからrealm.writeで囲む
            try! realm.write {
                selectMatchingPair.IsFavorite = true
            }
        }else{
            try! realm.write {
                selectMatchingPair.IsFavorite = false
            }
        }
        tableView.reloadData()
    }
    
}
