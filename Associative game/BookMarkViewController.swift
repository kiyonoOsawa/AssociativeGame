//
//  BookMarkViewController.swift
//  Associative game
//
//  Created by 大澤清乃 on 2021/08/01.
//

import UIKit
import RealmSwift

class BookMarkViewController: UIViewController, UITableViewDataSource,UITableViewDelegate {
    
    @IBOutlet var favoriteTableView: UITableView!
    var favoriteArray: [MatchingPair] = []
    let realm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.tintColor = UIColor.black
        favoriteTableView.rowHeight = 70
        favoriteTableView.backgroundColor = UIColor(named: "BackColor")
        favoriteTableView.tableFooterView = UIView()
        favoriteTableView.register(UINib(nibName: "BookMarkTableViewCell", bundle: nil), forCellReuseIdentifier: "Cell")
        favoriteTableView.dataSource = self
        favoriteTableView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.favoriteArray = Array(realm.objects(MatchingPair.self).filter("IsFavorite == true"))
        //for文を使ってIsFavoriteがtrueでなはないMatchingPairを配列から削除する
        for index in 0 ..< favoriteArray.count {
            let matchingPair = favoriteArray[index]
            //もしIsFavoriteがtrueでなければ
            if !matchingPair.IsFavorite {
                favoriteArray.remove(at: index)
            }
            favoriteTableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectMatchingPair = favoriteArray[indexPath.row]
        if selectMatchingPair.IsFavorite == true {
            try! realm.write {
                selectMatchingPair.IsFavorite = false
            }
        } else {
            try! realm.write {
                selectMatchingPair.IsFavorite = true
            }
        }
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoriteArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! BookMarkTableViewCell
        cell.selectionStyle = .none
        cell.datatextLabel.text = favoriteArray[indexPath.row].pair1!
        cell.ideatextLabel.text = favoriteArray[indexPath.row].pair2
        let selectMatchingPair = favoriteArray[indexPath.row]
        if selectMatchingPair.IsFavorite == true {
            cell.starImageView.image = UIImage(named: "star")
        } else {
            cell.starImageView.image = UIImage(named: "borderstar")
        }
        return cell
    }
}
