//
//  AddListViewController.swift
//  Associative game
//
//  Created by 大澤清乃 on 2021/09/18.
//

import UIKit
import RealmSwift


class AddListViewController: UIViewController,UITableViewDataSource,UITextFieldDelegate, UITableViewDelegate {
    
    @IBOutlet var addTableView: UITableView!
    var contentList: Results<Contents>!
    let realm = try! Realm()
    var savedItem: Item!
    var contentsArray = Array<Any>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.tintColor = UIColor.black
        addTableView.rowHeight = 70
        addTableView.backgroundColor = UIColor(named: "BackColor")
        addTableView.tableFooterView = UIView()
        addTableView.dataSource = self
        addTableView.delegate = self
        self.navigationItem.title = savedItem.title
        //データの取得
        let results = realm.objects(Item.self)
        self.contentList = realm.objects(Contents.self).filter("title == '\(self.savedItem.title!)'")
        self.addTableView.reloadData()
    }
    
    //    @IBAction func aleat(_ sender: Any) {
    //        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .alert)
    //        alert.view.tintColor = .black
    //        alert.title = "新しいアイディア"
    //        alert.message = "入力"
    //        alert.addTextField(configurationHandler: {(textField) -> Void in
    //            textField.delegate = self
    //        })
    //        //追加ボタン
    //        alert.addAction(
    //            UIAlertAction(
    //                title: "追加",
    //                style: .default,
    //                handler: {(action) -> Void in
    //                    self.hello(action.title!)
    //                    //textfieldを保存
    //                    if alert.textFields![0].text != "" {
    //                        let contents = Contents()
    //                        contents.title = self.savedItem.title
    //                        contents.content = alert.textFields![0].text
    //                        let realm = try! Realm()
    //
    //                        try! realm.write {
    //                            self.savedItem.contents.append(contents)
    //                        }
    //                        self.contentList = realm.objects(Contents.self).filter("title == '\(self.savedItem.title!)'")
    //                        self.addTableView.reloadData()
    //                        //スクロールするには最下部のIndexPathが必要
    //                        //IndexPathはSectionとrowの２つの要素で構成されている
    //                        //Sectionは1つしかないので0
    //                        //RowはContentsの要素数なので'self.savedItem.contents.count'または'self.contentList'から１引いた数
    //                        let section = 0
    //                        let row = self.contentList.count - 1
    //                        let indexPath = IndexPath(row: row, section: section)
    //                        //特定のCell番号(IndexPath)までスクロールしてくれるメソッド
    //                        self.addTableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
    //                    }
    //                })
    //        )
    //        alert.addAction(
    //            UIAlertAction(
    //                title: "キャンセル",
    //                style: .cancel,
    //                handler: {(action) -> Void in
    //                    self.hello(action.title!)
    //                })
    //        )
    //        self.present(
    //            alert,
    //            animated: true,
    //            completion: {
    //                print("アラートが表示された")
    //            })
    //    }
    //
    //    func hello(_ msg:String){
    //        print(msg)
    //    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let results = realm.objects(Item.self)
        let contents = Contents()
        contents.title = self.savedItem.title
        let realm = try! Realm()
        try! realm.write {
            self.savedItem.contents.append(contents)
        }
        self.contentList = realm.objects(Contents.self).filter("title == '\(self.savedItem.title!)'")
        realm.objects(Contents.self).filter("title == '\(self.savedItem.title!)'").last
        let section = 0
        let row = self.contentList.count - 1
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
