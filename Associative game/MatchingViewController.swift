//
//  MatchingViewController.swift
//  Associative game
//
//  Created by 大澤清乃 on 2021/07/04.
//

import UIKit
import RealmSwift

class MatchingViewController: UIViewController, UITableViewDataSource, UITabBarDelegate, UIPickerViewDataSource, UIPickerViewDelegate, UITableViewDelegate {
    
    @IBOutlet var ideaLabel: UILabel!
    @IBOutlet var matchinglist: UITableView!
    @IBOutlet var matchpick: UIPickerView!
    @IBOutlet var stock: UIButton!
    
    var randomContent: Contents!
    var item: Item!
    var contentList: [Contents] = []
    var tempArray: [Contents] = []
    var maxId: String{return try!Realm().objects(Item.self).sorted(byKeyPath: "id").last?.id ?? ""}
    let realm = try! Realm()
    
    override func viewDidLoad() {
        self.navigationController?.navigationBar.tintColor = UIColor(red: 8/255, green: 25/255, blue: 45/255, alpha: 1.0)
        super.viewDidLoad()
        
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
        
        return cell!
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
