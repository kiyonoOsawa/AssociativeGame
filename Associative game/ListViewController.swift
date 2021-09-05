//
//  ListViewController.swift
//  Associative game
//
//  Created by 大澤清乃 on 2021/08/07.
//

import UIKit
import RealmSwift

class ListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var listtableview: UITableView!
    var itemlist: Results<Contents>!
    let realm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.tintColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 1.0)
        self.navigationController?.navigationBar.titleTextAttributes = [
            .foregroundColor: UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 1.0)]
        // xibを入れる
        listtableview.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "Cell")
        listtableview.backgroundColor = UIColor(named: "BackColor")
        listtableview.tableFooterView = UIView()
        do{
            let realm = try Realm()
            itemlist = realm.objects(Contents.self)
            listtableview.reloadData()
        }catch{
        }
        listtableview.rowHeight = 70
        listtableview.delegate = self
        listtableview.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //データの取得
        self.itemlist = realm.objects(Contents.self)
        print("アイテムリスト")
        print(itemlist)
        listtableview.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemlist.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! TableViewCell
        //セルの選択状態
        cell.selectionStyle = .none
        let object = itemlist[indexPath.row]
        cell.tabletextLabel.text = itemlist[indexPath.row].content
        return cell
    }
}
