//
//  BananaViewController.swift
//  Associative game
//
//  Created by 大澤清乃 on 2021/02/01.
//

import UIKit

class BananaViewController: UIViewController,UITableViewDataSource {
    
    @IBOutlet var newbutton: UIButton!
    @IBOutlet var savetableview: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //tableviewの高さを変える
        savetableview.rowHeight = 90

        savetableview.dataSource = self
        //アイコンの大きさを変える
        for item in (self.tabBarController?.tabBar.items)! {
            item.imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        }
        // 画像と文字の選択時の色を指定（未選択字の色はデフォルトのまま）
        UITabBar.appearance().tintColor = UIColor.init(red: 8/255, green: 25/255, blue: 45/255, alpha: 100/100)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
        
        cell?.textLabel?.text = "テスト"
        
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
