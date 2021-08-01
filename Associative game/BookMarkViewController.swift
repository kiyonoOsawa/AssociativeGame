//
//  BookMarkViewController.swift
//  Associative game
//
//  Created by 大澤清乃 on 2021/08/01.
//

import UIKit
import RealmSwift

class BookMarkViewController: UIViewController, UITableViewDataSource,UITableViewDelegate {

    @IBOutlet var favoritetableview: UITableView!
    
    var favoriteArray: [MatchingPair] = []
    let realm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        favoritetableview.rowHeight = 90
        favoritetableview.dataSource = self
        favoritetableview.delegate = self

        // Do any additional setup after loading the view.
        self.navigationController?.navigationBar.tintColor = UIColor(red: 8/255, green: 25/255, blue: 45/255, alpha: 1.0)
        favoritetableview.register(UINib(nibName: "BookMarkTableViewCell", bundle: nil), forCellReuseIdentifier: "Cell")
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoriteArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! BookMarkTableViewCell
        cell.datatextLabel.text = favoriteArray[indexPath.row].pair1!
        cell.ideatextLabel.text = favoriteArray[indexPath.row].pair2
        return cell
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
