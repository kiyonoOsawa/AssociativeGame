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
    @IBOutlet var matchinglist: UITableView!
    @IBOutlet var matchpick: UIPickerView!
    @IBOutlet var stock: UIButton!
    
    var randomContent: Contents!
    var item: Item!
    var contentList: [Contents] = []
    var tempArray: [MatchingPair] = []
    var maxId: String{return try!Realm().objects(Item.self).sorted(byKeyPath: "id").last?.id ?? ""}
    let realm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.tintColor = UIColor(red: 8/255, green: 25/255, blue: 45/255, alpha: 1.0)
        
        matchinglist.register(UINib(nibName: "BookMarkTableViewCell", bundle: nil), forCellReuseIdentifier: "Cell")
        
        matchinglist.rowHeight = 90
        matchinglist.dataSource = self
        matchinglist.delegate = self
        matchpick.dataSource = self
        matchpick.delegate = self
        
        contentList = Array(item.contents)
        randomContent = item.contents.randomElement()
        ideaLabel.text = randomContent.content
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tempArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! BookMarkTableViewCell
        cell.datatextLabel.text = tempArray[indexPath.row].pair1!
        cell.ideatextLabel.text = tempArray[indexPath.row].pair2
        let selectMatchingPair = tempArray[indexPath.row]
        if selectMatchingPair.IsFavorite == false {
            cell.starimage.image = UIImage(named: "borderstar")
        }else{
            cell.starimage.image = UIImage(named: "star")
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectMatchingPair = tempArray[indexPath.row]
        if selectMatchingPair.IsFavorite == false {
            // realmの元のデータを書き換えるからrealm.writeで囲む
            try! realm.write {
                selectMatchingPair.IsFavorite = true
            }
        }else{
            try! realm.write {
                selectMatchingPair.IsFavorite = false
            }
        }
        tableView.reloadData()
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
        //Xibファイルを読み込む
        let custumView = UINib(nibName: "CardView", bundle: nil).instantiate(withOwner: nil, options: nil).first as! Card
        //高さを40に設定
        custumView.frame.size.height = 40
        //横幅を155に設定
        custumView.frame.size.width = 155
        //Xibファイル上に配置してあるラベルに表示する文字列を設定する
        custumView.label.text = contentList[row].content
        return custumView
    }
    
    @IBAction func tupstock () {
        //pickerviewの行を取得
        let contents = contentList[self.matchpick.selectedRow(inComponent: 0)]
        let matchingPair = MatchingPair()
        matchingPair.title = item.title
        matchingPair.pair1 = randomContent.content
        matchingPair.pair2 = contents.content
        matchingPair.IsFavorite = false
        tempArray.append(matchingPair)
        try! realm.write{
            realm.add(tempArray)
        }
        matchinglist.reloadData()
    }
    
    // Do any additional setup after loading the view.
    
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
