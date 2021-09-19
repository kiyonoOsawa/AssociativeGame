//
//  MatchingViewController.swift
//  Associative game
//
//  Created by 大澤清乃 on 2021/07/04.
//

import UIKit
import RealmSwift

class MatchingViewController: UIViewController, UITabBarDelegate, UITableViewDataSource, UITableViewDelegate, UIPickerViewDataSource, UIPickerViewDelegate{
    
    @IBOutlet var ideaLabel: UILabel!
    @IBOutlet var matchingList: UITableView!
    @IBOutlet var matchPick: UIPickerView!
    @IBOutlet var stockButton: UIButton!
    
    var fontArray = ["System Medium"]
    var randomContent: Contents!
    var item: Item!
    var contentList: [Contents] = []
    var tempArray: [MatchingPair] = []
    var maxId: String{return try!Realm().objects(Item.self).sorted(byKeyPath: "id").last?.id ?? ""}
    let realm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.tintColor = UIColor.black
        matchingList.rowHeight = 70
        matchingList.register(UINib(nibName: "BookMarkTableViewCell", bundle: nil), forCellReuseIdentifier: "Cell")
        matchingList.backgroundColor = UIColor(named: "BackColor")
        matchingList.tableFooterView = UIView() //セルがない下の部分を無くす
        matchingList.dataSource = self
        matchingList.delegate = self
        matchPick.dataSource = self
        matchPick.delegate = self
        contentList = Array(item.contents)
        if !contentList.isEmpty {
            //ContentListが空だとランダムな要素が取得できないのでクラッシュする  →if文で要素が１つでもある場合に限定する
            randomContent = item.contents.randomElement()!
            ideaLabel.text = randomContent.content
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tempArray = Array(realm.objects(MatchingPair.self).filter("title == %@", item.title!)) //MatchingPairのtitle変数とitem.titleが同じかを確認できる
        print(self.tempArray)
        if self.tempArray.count != 0 {
            //for文を使って表示されているアイデアと関係のないMatchingPairを配列から消去する
            for index in 0 ..< tempArray.count {
                let temp = tempArray[index]
                //もしタイトルが前の画面から受け渡されたitemのtitleと等しくなければ
                if temp.title != item.title {
                    tempArray.remove(at: index)
                }
            }
        }
        matchingList.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tempArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! BookMarkTableViewCell
        cell.selectionStyle = .none
        cell.datatextLabel.text = tempArray[indexPath.row].pair1!
        cell.ideatextLabel.text = tempArray[indexPath.row].pair2
        let selectMatchingPair = tempArray[indexPath.row]
        if selectMatchingPair.IsFavorite == false {
            cell.starImageView.image = UIImage(named: "borderstar")
        } else {
            cell.starImageView.image = UIImage(named: "star")
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectMatchingPair = tempArray[indexPath.row]
        if selectMatchingPair.IsFavorite == false {
            try! realm.write {
                selectMatchingPair.IsFavorite = true
            }
        } else {
            try! realm.write {
                selectMatchingPair.IsFavorite = false
            }
        }
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete {
            do{
                let realm = try! Realm()
                try! realm.write {
                    realm.delete(self.tempArray[indexPath.row])
                }
                tempArray.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.fade)
            } catch {
            }
            tableView.reloadData()
        }
    }
    
    //pickerviewの列の数
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    //pickerviewの行数、要素の全数
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        contentList.count
    }
    
    //pickerviewに表示する配列
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return contentList[row].content
    }
    
    //pickerviewに表示する独自のビューを設定する
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 40))
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        label.text = contentList[row].content
        let custumView = UINib(nibName: "CardView", bundle: nil).instantiate(withOwner: nil, options: nil).first as! Card
        custumView.frame.size.height = 40
        custumView.frame.size.width = 120
        custumView.label.text = contentList[row].content
        return custumView
        return label
    }
    
    @IBAction func tupstock () {
        //pickerviewの行を取得
        let contents = contentList[self.matchPick.selectedRow(inComponent: 0)]
        let matchingPair = MatchingPair()
        matchingPair.title = item.title
        matchingPair.pair1 = randomContent.content
        matchingPair.pair2 = contents.content
        matchingPair.IsFavorite = false
        tempArray.append(matchingPair)
        try! realm.write{
            realm.add(tempArray)
        }
        matchingList.reloadData()
    }
}
