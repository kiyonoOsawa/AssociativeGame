//
//  AddViewController.swift
//  Associative game
//
//  Created by 大澤清乃 on 2021/03/06.
//

import UIKit

class AddViewController: UIViewController,UITableViewDataSource,UITextFieldDelegate {
    
    @IBOutlet var addtableview: UITableView!
    
    @IBAction func backbutton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func aleat(_ sender: Any) {
        
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .alert)
        alert.title = "入力"
        alert.message = "追加"
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
        
        cell?.textLabel?.text = "テスト"
        
        return cell!
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addtableview.rowHeight = 90
        addtableview.dataSource = self
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
