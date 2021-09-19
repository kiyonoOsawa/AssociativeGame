//
//  MatchListViewController.swift
//  Associative game
//
//  Created by 大澤清乃 on 2021/08/07.
//

import UIKit
import RealmSwift

class MatchListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var matchListTableView: UITableView!
    var matchList: [MatchingPair] = []
    let realm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.tintColor = UIColor.black
        matchListTableView.rowHeight = 70
        matchListTableView.register(UINib(nibName: "BookMarkTableViewCell", bundle: nil), forCellReuseIdentifier: "Cell")
        matchListTableView.backgroundColor = UIColor(named: "BackColor")
        matchListTableView.tableFooterView = UIView()
        matchListTableView.delegate = self
        matchListTableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.matchList = Array(realm.objects(MatchingPair.self))
        print(matchList)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return matchList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! BookMarkTableViewCell
        cell.selectionStyle = .none
        cell.datatextLabel.text = matchList[indexPath.row].pair1!
        cell.ideatextLabel.text = matchList[indexPath.row].pair2
        let selectMatchingPair = matchList[indexPath.row]
        if selectMatchingPair.IsFavorite == true {
            cell.starImageView.image = UIImage(named: "star")
        } else {
            cell.starImageView.image = UIImage(named: "borderstar")
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectMatchingPair = matchList[indexPath.row]
        if selectMatchingPair.IsFavorite == false {
            try! realm.write {
                selectMatchingPair.IsFavorite = true
            }
        } else {
            try! realm.write {
                selectMatchingPair.IsFavorite = false
            }
        }
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete {
            do{
                let realm = try! Realm()
                try! realm.write {
                    realm.delete(self.matchList[indexPath.row])
                }
                matchList.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.fade)
            } catch {
            }
            tableView.reloadData()
        }
    }
}
