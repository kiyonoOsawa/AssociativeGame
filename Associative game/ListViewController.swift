//
//  ListViewController.swift
//  Associative game
//
//  Created by 大澤清乃 on 2021/08/07.
//

import UIKit
import RealmSwift

class ListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var listTableView: UITableView!
    var itemList: Results<Contents>!
    let realm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.tintColor = UIColor.black
        listTableView.rowHeight = 70
        listTableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "Cell")
        listTableView.backgroundColor = UIColor(named: "BackColor")
        listTableView.tableFooterView = UIView()
        listTableView.delegate = self
        listTableView.dataSource = self
        do{
            let realm = try Realm()
            itemList = realm.objects(Contents.self)
            listTableView.reloadData()
        } catch {
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.itemList = realm.objects(Contents.self)
        listTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! TableViewCell
        cell.selectionStyle = .none
        let object = itemList[indexPath.row]
        cell.tabletextLabel.text = itemList[indexPath.row].content
        return cell
    }
}
