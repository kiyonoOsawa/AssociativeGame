//
//  DetailsViewController.swift
//  Associative game
//
//  Created by 大澤清乃 on 2021/05/09.
//

import UIKit
import RealmSwift

class DetailsViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var timerSwitch: UISwitch!
//    @IBOutlet weak var topImageView: UIButton!
    @IBOutlet weak var imageGroupView: UIView!
    @IBOutlet weak var popImageView: UIImageView!
    @IBOutlet var libraryButton: UIButton!     //ライブラリから選ぶためのbutton
    @IBOutlet weak var selectImageIcon: UIButton!    //今選んでいる画像が表示されるbutton
    @IBOutlet var firstIcon: UIButton!
    @IBOutlet var secondIcon: UIButton!
    @IBOutlet var thirdIcon: UIButton!
    @IBOutlet var fourthIcon: UIButton!
    @IBOutlet var fifthIcon: UIButton!
    @IBOutlet var sixthIcon: UIButton!
    @IBOutlet var seventhIcon: UIButton!
    @IBOutlet var eighthIcon: UIButton!
    @IBOutlet var ninthIcon: UIButton!
    @IBOutlet var tenthIcon: UIButton!
    @IBOutlet var eleventhIcon: UIButton!
    @IBOutlet var twelfthIcon: UIButton!
    @IBOutlet var thirteenthIcon: UIButton!
    @IBOutlet var fourteenthIcon: UIButton!
    @IBOutlet var fifteenthIcon: UIButton!
    @IBOutlet var sixteenthIcon: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //吹き出しを隠す
        imageGroupView.isHidden = true
        // selectImageIconの角丸
        let tapCG: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapCG.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tapCG)
        designImage()
    }
    
    func designImage() {
        selectImageIcon.layer.cornerRadius = 10
        selectImageIcon.layer.borderColor = UIColor.black.cgColor
        selectImageIcon.layer.borderWidth = 1
        titleTextField.layer.cornerRadius = 10
        titleTextField.layer.borderColor = UIColor.black.cgColor
        titleTextField.layer.borderWidth = 0.6
        //吹き出しの角丸
        self.popImageView.layer.cornerRadius = 25
        self.selectImageIcon.layer.cornerRadius = 10
        self.selectImageIcon.layer.masksToBounds = true
        let leftPadding = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        titleTextField.leftView = leftPadding
        titleTextField.leftViewMode = .always
        titleTextField.placeholder = "New Project"
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        imageGroupView.isHidden = true
    }
    
    @IBAction func saveButton(_ sender: UIButton) {
        self.presentingViewController?.dismiss(animated: true, completion: nil)
        let item = Item()
        let dt = Date()
        item.title = titleTextField.text!
        item.timer = timerSwitch.isOn
        item.icon = selectImageIcon.currentImage?.pngData()
        item.date = dt
//        dateFormatter.locale = Locale(identifier: "ja_JP")
//        dateFormatter.dateStyle = .medium
        

        do{
            let realm = try! Realm()
            try realm.write({ () -> Void in
                realm.add(item)
            })
        } catch {
            print("Save is Faild")
        }
    }
    
    @objc func dismissKeyboard() {
        self.view.endEditing(true)
    }
    
    @IBAction func cancelButton(_ sender: UIButton) {
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    //今選択している画像のボタンを押したときに実行するメソッド
    @IBAction func tapSelectImage() {
        //吹き出しを表示する
        imageGroupView.isHidden = false
    }
    
    //ライブラリを開くボタンを押した時に実行するメソッド
    @IBAction func tapLibraryButton() {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true //選択した画像を編集できるようにする
        picker.sourceType = .photoLibrary
        present(picker, animated: true, completion: nil)
    }
    
    //吹き出しの1枚目の画像を押した時に実行されるメソッド
    @IBAction func tapFirstImageButton() {
        let newImage = firstIcon.currentImage
        selectImageIcon.setImage(newImage, for: .normal)
    }
    
    //吹き出しの2枚目の画像を押した時に実行されるメソッド
    @IBAction func tapSecondButton() {
        let newImage = secondIcon.currentImage
        selectImageIcon.setImage(newImage, for: .normal)
    }
    
    //吹き出し3枚目の画像を押した時に実行されるメソッド
    @IBAction func tapThirdImageButton() {
        let newImage = thirdIcon.currentImage
        selectImageIcon.setImage(newImage, for: .normal)
    }
    
    //吹き出し4枚目の画像を押した時に実行されるメソッド
    @IBAction func tapFourthImageButton() {
        let newImage = fourthIcon.currentImage
        selectImageIcon.setImage(newImage, for: .normal)
    }
    
    //吹き出し5枚目の画像を押した時に実行されるメソッド
    @IBAction func tapFifthImageButton() {
        let newImage = fifthIcon.currentImage
        selectImageIcon.setImage(newImage, for: .normal)
    }
    
    //吹き出し6枚目の画像を押した時に実行されるメソッド
    @IBAction func tapSixthImageButton() {
        let newImage = sixthIcon.currentImage
        selectImageIcon.setImage(newImage, for: .normal)
    }
    
    //吹き出し7枚目の画像を押した時に実行されるメソッド
    @IBAction func tapSeventhImageButton() {
        let newImage = seventhIcon.currentImage
        selectImageIcon.setImage(newImage, for: .normal)
    }
    
    //吹き出し8枚目の画像を押した時に実行されるメソッド
    @IBAction func tapEighthImageButton() {
        let newImage = eighthIcon.currentImage
        selectImageIcon.setImage(newImage, for: .normal)
    }
    
    //吹き出し9枚目の画像を押した時に実行されるメソッド
    @IBAction func tapNinthImageButton() {
        let newImage = ninthIcon.currentImage
        selectImageIcon.setImage(newImage, for: .normal)
    }
    
    //吹き出し10枚目の画像を押した時に実行されるメソッド
    @IBAction func tapTenthImageButton() {
        let newImage = tenthIcon.currentImage
        selectImageIcon.setImage(newImage, for: .normal)
    }
    
    //吹き出し11枚目の画像を押した時に実行されるメソッド
    @IBAction func tapEleventhImageButton() {
        let newImage = eleventhIcon.currentImage
        selectImageIcon.setImage(newImage, for: .normal)
    }
    
    //吹き出し12枚目の画像を押した時に実行されるメソッド
    @IBAction func tapTwelfthImageButton() {
        let newImage = twelfthIcon.currentImage
        selectImageIcon.setImage(newImage, for: .normal)
    }
    
    //吹き出し13枚目の画像を押した時に実行されるメソッド
    @IBAction func tapThirteenthImageButton() {
        let newImage = thirteenthIcon.currentImage
        selectImageIcon.setImage(newImage, for: .normal)
    }
    
    //吹き出し14枚目の画像を押した時に実行されるメソッド
    @IBAction func tapFourteenthImageButton() {
        let newImage = fourteenthIcon.currentImage
        selectImageIcon.setImage(newImage, for: .normal)
    }
    
    //吹き出し15枚目の画像を押した時に実行されるメソッド
    @IBAction func tapFifteenthImageButton() {
        let newImage = fifteenthIcon.currentImage
        selectImageIcon.setImage(newImage, for: .normal)
    }
    
    //吹き出し16枚目の画像を押した時に実行されるメソッド
    @IBAction func tapSixteenthImageButton() {
        let newImage = sixteenthIcon.currentImage
        selectImageIcon.setImage(newImage, for: .normal)
    }
    
    //UIImagePickerViewControllerから画像の選択が完了した時に実行されるメソッド
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        //選択した画像を変数に格納する
        let image = info[.editedImage] as? UIImage
        //selectImageButtonの画像にセットする
        selectImageIcon.setImage(image, for: .normal)
        //UIImagePickerViewControllerを閉じる
        picker.dismiss(animated: true, completion: nil)
    }
}
