//
//  DetailsViewController.swift
//  Associative game
//
//  Created by 大澤清乃 on 2021/05/09.
//

import UIKit
import RealmSwift

class DetailsViewController: UIViewController {
    
    @IBOutlet var titletextField: UITextField!
    @IBOutlet var timerswitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titletextField.layer.cornerRadius = 7
        titletextField.layer.borderColor = CGColor(red: 8/255, green: 25/255, blue: 45/255, alpha: 0.4)
        titletextField.layer.borderWidth = 0.6
        
        // Do any additional setup after loading the view.
    }
    @IBAction func saveButton(_ sender: UIButton) {
        self.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
        
        let item = Item()
        item.title = titletextField.text!
        item.timer = timerswitch.isOn
        
        do{
            let realm = try! Realm()
            try realm.write({ () -> Void in
                realm.add(item)
                print("title Saved")
                print("timer Saved")
            })
        } catch {
            print("Save is Faild")
        }
    }
    @IBAction func cancelButton(_ sender: UIButton) {
        self.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
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
