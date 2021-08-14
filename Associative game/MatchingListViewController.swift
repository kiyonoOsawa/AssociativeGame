//
//  MatchingListViewController.swift
//  Associative game
//
//  Created by 大澤清乃 on 2021/07/18.
//

import UIKit
import RealmSwift

class MatchingListViewController: UIViewController,UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet var matchtableview: UITableView!
    var itemList: Results<Item>!
    var contentList: Results<Contents>!
    var maxId: String{return try!Realm().objects(Item.self).sorted(byKeyPath: "id").last?.id ?? ""}
    let realm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.tintColor = UIColor(red: 15/255, green: 37/255, blue: 64/255, alpha: 1.0)
        self.navigationController?.navigationBar.titleTextAttributes = [
            .foregroundColor: UIColor(red: 15/255, green: 37/255, blue: 64/255, alpha: 1.0)]
        
        do{
            let realm = try Realm()
            itemList = realm.objects(Item.self)
            matchtableview.reloadData()
        }catch{
            
        }
        
        print(Realm.Configuration.defaultConfiguration.fileURL!)
        //tableviewの高さを変える
        matchtableview.rowHeight = 70
        matchtableview.delegate = self
        matchtableview.dataSource = self
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //データの取得
        self.itemList = realm.objects(Item.self)
        self.contentList = realm.objects(Contents.self)
        matchtableview.reloadData()
    }
    // セルの編集許可
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
//                itemList.remove(at: indexPath.row)
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
        //cell選択時の色を透明にする
        var cellSelectedBgView = UIView()
        cellSelectedBgView.backgroundColor = UIColor.clear
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
        let object = itemList[indexPath.row]
        cell?.textLabel?.text = itemList[indexPath.row].title
        print(itemList[indexPath.row].title)
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //画面遷移が行われる
        performSegue(withIdentifier: "matching", sender: itemList[indexPath.row])
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "matching" {
            let nextViewController = segue.destination as! MatchingViewController
            nextViewController.item = sender as? Item
        }
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
