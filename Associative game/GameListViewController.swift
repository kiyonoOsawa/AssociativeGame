//
//  GameListViewController.swift
//  Associative game
//
//  Created by 大澤清乃 on 2021/09/18.
//

import UIKit
import RealmSwift

class GameListViewController: UIViewController,UITableViewDataSource,UITextFieldDelegate, UITableViewDelegate  {
    
    @IBOutlet var addTableView: UITableView!
//    @IBOutlet var timerLabel: UILabel!
//    @IBOutlet var startButton: UIButton!
    @IBOutlet var alertImage: UIImageView!
    var contentList: Results<Contents>!
    let realm = try! Realm()
    var savedItem: Item!
    var contentsArray = Array<Any>()
//    //Timerクラスのインスタンスの作成
//    var timer: Timer = Timer()
//    //制限時間の残り時間をカウントする変数
//    var count: Int = 30

    override func viewDidLoad() {
        super.viewDidLoad()
//        self.timerLabel.layer.cornerRadius = 38
//        self.timerLabel.clipsToBounds = true
//        self.timerLabel.layer.borderWidth = 2
//        self.timerLabel.layer.borderColor = UIColor(red: 153/255, green: 153/255, blue: 153/255, alpha: 1).cgColor
        self.navigationController?.navigationBar.tintColor = UIColor.black
        addTableView.rowHeight = 70
        addTableView.backgroundColor = UIColor(named: "BackColor")
        addTableView.tableFooterView = UIView()
        addTableView.dataSource = self
        addTableView.delegate = self
        let results = realm.objects(Item.self)
        self.contentList = realm.objects(Contents.self).filter("title == '\(self.savedItem.title!)'")
        let realm = try! Realm()
        self.navigationItem.title = savedItem.title
    }
//    @IBAction func startGame() {
//        //タイマーが動いているかの確認(二重で進むのを防ぐ）
//        if !timer.isValid {
//            startButton.setImage(UIImage(named: "stop"), for: .normal)
//            timer = Timer.scheduledTimer(
//                timeInterval: 1, //1秒ごとにselectorに処理を実行する
//                target: self,
//                selector: #selector(self.timerCount), //1秒ごとに実行されるメソッドの指定
//                userInfo: nil,
//                repeats: true //毎秒処理を実行したいので、'repeats: true'としてあげる
//            )
//        } else {
//            startButton.setImage(UIImage(named: "start"), for: .normal)
//            finishGame()
//        }
//    }
    
//    func finishGame() {
//        //タイマーを終了
//        timer.invalidate()
//        count = 30
//        //アラート
//        let alert: UIAlertController = UIAlertController(title: "Finish", message: "", preferredStyle: .alert)
//        // 表示させる
//        alert.view.tintColor = UIColor(red: 255/255, green: 222/255, blue: 0/255, alpha: 1)
//        present(alert, animated: true, completion: nil)
//        alert.view.tintColor = .black
//        // アラートを閉じる
//        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: {
//            alert.dismiss(animated: true, completion: nil)
//        })
//    }
    
//    @objc func timerCount() {
//        //変数を1秒減らす
//        count -= 1
//        timerLabel.text = String(count)
//        //残り5,3,1秒
//        if count == 5 || count == 3 || count == 1 {
//            alertImage.isHidden = false
//        } else if count == 4 || count == 2 {
//            alertImage.isHidden = true
//        } else {
//            alertImage.isHidden = true
//        }
//        //ゲームが終了したかの確認
//        if count == 0 {
//            startButton.setImage(UIImage(named: "start"), for: .normal)
//            finishGame()
//        }
//    }
    
//    @IBAction func aleat(_ sender: Any) {
//        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .alert)
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
        self.contentList = realm.objects(Contents.self).filter("title == '\(self.savedItem.title!)'")
        addTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contentList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == contentList.count - 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "LastCell") as! AddTableViewCell
            cell.selectionStyle = .none
            cell.ideaLabel.text = contentList[indexPath.row].content
            return cell
        } else {
            //最新アイテムでない場合
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! AddTableViewCell
            cell.selectionStyle = .none
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
            } catch {
            }
            tableView.reloadData()
        }
    }
}
