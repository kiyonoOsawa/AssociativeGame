//
//  AddViewController.swift
//  Associative game
//
//  Created by 大澤清乃 on 2021/03/06.
//

import UIKit
import RealmSwift

class AddViewController: UIViewController,UITableViewDataSource,UITextFieldDelegate {
    
    @IBOutlet var addtableview: UITableView!
    var contentList: Results<Contents>!
    let realm = try! Realm()
    var savedTitle: String!
    var contentsArray = Array<Any>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("値渡し\(savedTitle) in viewdidload")
        addtableview.rowHeight = 90
        addtableview.dataSource = self
//        savedTitle = (saveData.object(forKey: "Title") as! String)
        let realm = try! Realm()


        let results = realm.objects(Contents.self)
        print("保存後")
        print(results)
        
    }
    
    @IBAction func backbutton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
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
                        contents.title = self.savedTitle
                        contents.content = alert.textFields![0].text
                        let realm = try! Realm()

                        try! realm.write {
                            realm.add(contents)
//                            realm.add(contentlist)
                        }
                        self.contentList = realm.objects(Contents.self).filter("title == '\(self.savedTitle!)'")
//
                        print("中身")
                        print(self.contentList)
//                        self.contentList = realm.objects(Contents.self).filter("title == 'f'")
                        self.addtableview.reloadData()
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
        self.contentList = realm.objects(Contents.self).filter("title == '\(self.savedTitle!)'")
//        self.contentList = realm.objects(Contents.self).filter("title == ''")
        print("中身")
        print(contentList)
        
        addtableview.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contentList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
    
        cell?.textLabel?.text = contentList[indexPath.row].content
        return cell!
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
