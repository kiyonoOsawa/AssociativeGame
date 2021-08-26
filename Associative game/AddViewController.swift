//
//  AddViewController.swift
//  Associative game
//
//  Created by 大澤清乃 on 2021/03/06.
//

import UIKit
import RealmSwift

class AddViewController: UIViewController,UITableViewDataSource,UITextFieldDelegate, UITableViewDelegate {
    
    @IBOutlet var addtableview: UITableView!
    var contentList: Results<Contents>!
    let realm = try! Realm()
    var savedItem: Item!
    var contentsArray = Array<Any>()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.tintColor = UIColor(red: 15/255, green: 37/255, blue: 64/255, alpha: 1.0)
        
        //      print("値渡し\(savedItem) in viewdidload")
        addtableview.rowHeight = 70
        addtableview.dataSource = self
        addtableview.delegate = self
        let realm = try! Realm()
        
        let results = realm.objects(Contents.self)
        print("保存後")
        print(results)
        self.navigationItem.title = savedItem.title
        self.navigationController?.navigationBar.titleTextAttributes = [
            .foregroundColor: UIColor(red: 15/255, green: 37/255, blue: 64/255, alpha: 1.0)]
        
    }
    
    @IBAction func aleat(_ sender: Any) {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .alert)
        alert.title = "新しいアイディア"
        alert.message = "入力"
        alert.addTextField(configurationHandler: {(textField) -> Void in
            textField.delegate = self
        })
        //追加ボタン
        alert.addAction(
            UIAlertAction(
                title: "追加",
                style: .default,
                handler: {(action) -> Void in
                    self.hello(action.title!)
                    //textfieldを保存
                    if alert.textFields![0].text != "" {
                        let contents = Contents()
                        contents.title = self.savedItem.title
                        contents.content = alert.textFields![0].text
                        let realm = try! Realm()
                        
                        try! realm.write {
                            //                            realm.add(savedItem)
                            self.savedItem.contents.append(contents)
                        }
                        self.contentList = realm.objects(Contents.self).filter("title == '\(self.savedItem.title!)'")
                        self.addtableview.reloadData()
                        //スクロールするには最下部のIndexPathが必要
                        //IndexPathはSectionとrowの２つの要素で構成されている
                        //Sectionは1つしかないので0
                        //RowはContentsの要素数なので'self.savedItem.contents.count'または'self.contentList'から１引いた数
                        let section = 0
                        let row = self.contentList.count - 1
                        let indexPath = IndexPath(row: row, section: section)
                        //特定のCell番号(IndexPath)までスクロールしてくれるメソッド
                        self.addtableview.scrollToRow(at: indexPath, at: .bottom, animated: true)
                        
                    }
                    
                })
        )
        alert.addAction(
            UIAlertAction(
                title: "キャンセル",
                style: .cancel,
                handler: {(action) -> Void in
                    self.hello(action.title!)
                })
        )
        self.present(
            alert,
            animated: true,
            completion: {
                print("アラートが表示された")
            })
    }
    func hello(_ msg:String){
        print(msg)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //データの取得
        let results = realm.objects(Item.self)
        self.contentList = realm.objects(Contents.self).filter("title == '\(self.savedItem.title!)'")
        print("中身")
        print(contentList)
        
        addtableview.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contentList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //cell選択時の色を透明にする
        var cellSelectedBgView = UIView()
        cellSelectedBgView.backgroundColor = UIColor.clear
        
        if indexPath.row == contentList.count - 1 {
            //3つあるうちの最新アイテムの場合
            let cell = tableView.dequeueReusableCell(withIdentifier: "LastCell") as! AddTableViewCell
            cell.ideaLabel.text = contentList[indexPath.row].content
            return cell
        } else {
            //最新アイテムでない場合
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! AddTableViewCell
            cell.ideaLabel.text = contentList[indexPath.row].content
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
            }catch{
            }
            tableView.reloadData()
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
