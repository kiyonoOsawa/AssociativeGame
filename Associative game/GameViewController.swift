//
//  GameViewController.swift
//  Associative game
//
//  Created by 大澤清乃 on 2021/09/18.
//

import UIKit
import RealmSwift

class GameViewController: UIViewController {
    
    @IBOutlet var beforeLabel: UILabel!
    @IBOutlet var addTextField: UITextField!
    @IBOutlet var saveButton: UIButton!
    @IBOutlet var timerLabel: UILabel!
    @IBOutlet var startButton: UIButton!
    @IBOutlet var alertImageView: UIImageView!
    var listButtonItem: UIBarButtonItem!
    var timer: Timer = Timer()
    var count: Int = 30
    var savedItem: Item!
    var content: Results<Contents>!
    let realm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController!.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController!.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.tintColor = UIColor.black
        self.timerLabel.layer.cornerRadius = 30
        self.timerLabel.clipsToBounds = true
        self.timerLabel.layer.borderWidth = 2
        self.timerLabel.layer.borderColor = UIColor.gray.cgColor
        let border = CALayer()
        let width = CGFloat(2.0)
        border.borderColor = UIColor.black.cgColor
        border.frame = CGRect(x: 0, y: addTextField.frame.size.height - width, width: addTextField.frame.size.width, height: 1)
        border.borderWidth = width
        addTextField.placeholder = " Word"
        addTextField.layer.addSublayer(border)
        beforeLabel.layer.cornerRadius = 15
        beforeLabel.layer.borderColor = UIColor.black.cgColor
        beforeLabel.layer.borderWidth = 1
        self.navigationItem.title = savedItem.title
        listButtonItem = UIBarButtonItem(title:"List", style: .done, target: self, action: #selector(taplistButton))
        self.navigationItem.rightBarButtonItem = listButtonItem
        if savedItem.contents.isEmpty {
            beforeLabel.text = savedItem.title
        } else {
            beforeLabel.text = savedItem.contents.last?.content
        }
        let results = realm.objects(Item.self)
        self .content = realm.objects(Contents.self).filter("title == '\(self.savedItem.title)'")
        let realm = try! Realm()
        let tapCG: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapCG.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tapCG)
        addTextField.becomeFirstResponder()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let results = realm.objects(Item.self)
        self.content = realm.objects(Contents.self).filter("title == '\(self.savedItem.title!)'")
    }
    
    @objc func dismissKeyboard() {
        self.view.endEditing(true)
    }
    
    @objc func taplistButton() {
        let vc = storyboard?.instantiateViewController(identifier: "addListVC") as! AddListViewController
        vc.savedItem = savedItem
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func tapsaveButton(_ sender: Any) {
        self.presentingViewController?.dismiss(animated: true, completion: nil)
        let contents = Contents()
        contents.title = self.savedItem.title
        contents.content = addTextField.text!
        if contents.content == "" {
            return
        } else {
            contents.content = addTextField.text!
            beforeLabel.text = contents.content
        }
        do {
            let realm = try!Realm()
            try realm.write({ () -> Void in
                self.savedItem.contents.append(contents)
            })
        } catch {
            print("Save is Faild")
        }
        addTextField.text = ""
        addTextField.becomeFirstResponder()
    }
    
    @IBAction func startGame() {
        //タイマーが動いているかの確認(二重で進むのを防ぐ）
        if !timer.isValid {
            startButton.setImage(UIImage(named: "stop"), for: .normal)
            timer = Timer.scheduledTimer(
                timeInterval: 1, // 1秒ごとにselectorに処理を実行する
                target: self,
                selector: #selector(self.timerCount), // 1秒ごとに実行されるメソッドの指定
                userInfo: nil,
                repeats: true  // 毎秒処理を実行したいので、'repeats: true'としてあげる
            )
        } else {
            startButton.setImage(UIImage(named: "start"), for: .normal)
            finishGame()
        }
    }
    
    func finishGame() {
        // タイマーを終了
        timer.invalidate()
        count = 30
        // アラート
        let alert: UIAlertController = UIAlertController(title: "Finish", message: "", preferredStyle: .alert)
        // 表示させる
        alert.view.tintColor = UIColor.black
        present(alert, animated: true, completion: nil)
        alert.view.tintColor = .black
        // アラートを閉じる
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: {
            alert.dismiss(animated: true, completion: nil)
        })
        // タイマーラベルに30を表示
        timerLabel.text = "30"
    }
    @objc func timerCount() {
        //変数を1秒減らす
        count -= Int(1.0)
        timerLabel.text = String(count)
        //残り5,3,1秒
        if count == 5 || count == 3 || count == 1 {
            alertImageView.isHidden = false
        } else if count == 4 || count == 2 {
            alertImageView.isHidden = true
        } else {
            alertImageView.isHidden = true
        }
        //ゲームが終了したかの確認
        if count == 0 {
            startButton.setImage(UIImage(named: "start"), for: .normal)
            finishGame()
        }
    }
}
