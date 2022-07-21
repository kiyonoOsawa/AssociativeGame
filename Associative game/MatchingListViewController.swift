//
//  MatchingListViewController.swift
//  Associative game
//
//  Created by 大澤清乃 on 2021/07/18.
//

import UIKit
import RealmSwift

class MatchingListViewController: UIViewController,UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet var matchTableView: UITableView!
    var itemList: Results<Item>!
    var contentList: Results<Contents>!
    var maxId: String{return try!Realm().objects(Item.self).sorted(byKeyPath: "id").last?.id ?? ""}
    let realm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.tintColor = UIColor.black
        matchTableView.rowHeight = 70
        matchTableView.register(UINib(nibName: "BananaTableViewCell", bundle: nil), forCellReuseIdentifier: "Cell")
        matchTableView.backgroundColor = UIColor(named: "BackColor")
        matchTableView.tableFooterView = UIView() //セルがない下の部分を無くす
        matchTableView.delegate = self
        matchTableView.dataSource = self
        do{
            let realm = try Realm()
            itemList = realm.objects(Item.self)
            matchTableView.reloadData()
        } catch {
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.itemList = realm.objects(Item.self)
        self.contentList = realm.objects(Contents.self)
        matchTableView.reloadData()
    }
    
    func moveToAddViewController(item: Item) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "addVC") as! AddViewController
        vc.savedItem = item
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! BananaTableViewCell
        cell.selectionStyle = .none
        cell.backgroundColor = UIColor(named: "BackColor")
        cell.titletextLabel.text = itemList[indexPath.row].title
        cell.accessoryType = UITableViewCell.AccessoryType.disclosureIndicator
        let object = itemList[indexPath.row]
        let icon = UIImage(data: itemList[indexPath.row].icon ?? Data())
        cell.iconImageView.image = icon
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd"
        cell.datetextLabel?.text = dateFormatter.string(from: itemList[indexPath.row].date ?? Date())
        print(itemList[indexPath.row].title)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = itemList[indexPath.row]
        if item.contents.isEmpty {
            let alert = UIAlertController(title: "ワードが空です", message: "追加画面からアイデアを追加しましょう", preferredStyle: .alert)
            alert.view.tintColor = .black
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            alert.addAction(UIAlertAction(title: "追加画面へ", style: .default, handler: { _ in
                self.moveToAddViewController(item: item)
            }))
            present(alert, animated: true, completion: nil)
        } else {
            //Itemのcontentsがあるので画面遷移が行われる
            performSegue(withIdentifier: "matching", sender: itemList[indexPath.row])
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "matching" {
            let nextViewController = segue.destination as! MatchingViewController
            nextViewController.item = sender as? Item
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
                    realm.delete(self.itemList[indexPath.row])
                }
                tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.fade)
            } catch {
            }
            tableView.reloadData()
        }
    }
}

