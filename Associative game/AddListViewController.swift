//
//  AddListViewController.swift
//  Associative game
//
//  Created by 大澤清乃 on 2021/09/18.
//

import UIKit
import RealmSwift


class AddListViewController: UIViewController,UITableViewDataSource,UITextFieldDelegate, UITableViewDelegate {
    
    @IBOutlet weak var addTableView: UITableView!
    var contentList: Results<Contents>!
    let realm = try! Realm()
    var savedItem: Item!
    var contentsArray = Array<Any>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //データの取得
        let results = realm.objects(Item.self)
        self.contentList = realm.objects(Contents.self).filter("itemId == '\(self.savedItem.id)'")
        self.addTableView.reloadData()
        designImage()
    }
    
    func designImage() {
        self.navigationController?.navigationBar.tintColor = UIColor.black
        self.navigationItem.title = savedItem.title
        addTableView.rowHeight = 70
        addTableView.backgroundColor = UIColor(named: "BackColor")
        addTableView.tableFooterView = UIView()
        addTableView.dataSource = self
        addTableView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        realm.objects(Contents.self).filter("title == '\(self.savedItem.title!)'").last
        let section = 0
        let row = self.contentList.count - 1
        if row == -1 {
            return
        }
        let indexPath = IndexPath(row: row, section: section)
        DispatchQueue.main.async {
            self.addTableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
        }
        addTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contentList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == contentList.count - 1 {
            //3つあるうちの最新アイテムの場合
            let cell = tableView.dequeueReusableCell(withIdentifier: "LastCell") as! AddTableViewCell
            cell.selectionStyle = .none
            cell.ideaLabel.text = contentList[indexPath.row].content
            return cell
        } else {
            //最新アイテムでない場合
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! AddTableViewCell
            cell.ideaLabel.text = contentList[indexPath.row].content
            cell.selectionStyle = .none
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete {
            do{
                let realm = try! Realm()
                try! realm.write {
                    realm.delete(self.contentList[indexPath.row])
                }
                tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.fade)
            } catch {
            }
            tableView.reloadData()
        }
    }
}
