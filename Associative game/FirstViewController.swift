//
//  FirstViewController.swift
//  Associative game
//
//  Created by 大澤清乃 on 2021/09/23.
//

import UIKit
import EAIntroView

class FirstViewController: UIViewController, EAIntroDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "BackColor")
           walkThrough()
//                let page1 = EAIntroPage()
//                //画像の設定
//                page1.bgImage = UIImage(named: "iphone_1")
//                //ここでページを追加
//                let introView = EAIntroView(frame: self.view.bounds, andPages: [page1])
//                //スキップボタンのテキスト
//                introView?.skipButton.setTitle("スキップ", for: UIControl.State.normal)
//                //スキップボタンの色変更
//                introView?.skipButton.setTitleColor(UIColor.white, for: UIControl.State.normal)
//                introView?.delegate = self
//                //アニメーション設定
//                introView?.show(in: self.view, animateDuration: 0.5)
    }
    
    func walkThrough() {
        let page1 = EAIntroPage()
        let page2 = EAIntroPage()
        let page3 = EAIntroPage()
        page1.bgColor = UIColor(named: "BackColor")
        page2.bgColor = UIColor(named: "BackColor")
        page3.bgColor = UIColor(named: "BackColor")
        //ipadの場合の処理
            if UIDevice.current.userInterfaceIdiom == .pad {
                page1.bgImage = UIImage(named: "ipad_1")
                page2.bgImage = UIImage(named: "ipad_2")
                page3.bgImage = UIImage(named: "ipad_3")
            } else {
                page1.bgImage = UIImage(named: "iphone_1")
                page2.bgImage = UIImage(named: "iphone_2")
                page3.bgImage = UIImage(named: "iphone_3")
            }
            let introView = EAIntroView(frame: self.view.bounds, andPages: [page1, page2, page3])
            introView?.skipButton.setTitle("スキップ", for: UIControl.State.normal)
            //スキップボタン欲しいならここで実装！
            introView?.delegate = self
            introView?.show(in: self.view, animateDuration: 1.0)
        }
    //スキップした時としなかった時で実装内容を分岐する事ができるメソッド。
    func introDidFinish(_ introView: EAIntroView!, wasSkipped: Bool) {
            if(wasSkipped) {
                //ここでもUserDefaultsで分岐している。trueの場合、メニュー画面の使い方からの遷移なのでdismissで戻る。
                if UserDefaults.standard.bool(forKey: "WalkThrough") == true {
                    dismiss(animated: true, completion: nil)
                } else {
                    //false(初回起動時)の場合、初回起動時での遷移なのでメイン画面へ
                    let MainViewController = BananaViewController.init()
                    let NV = UINavigationController.init(rootViewController: MainViewController)
                    NV.modalPresentationStyle = .fullScreen
                    present(NV, animated: true, completion: nil)
                    //UserDefaultsにtrueを保持させる
                    UserDefaults.standard.set(true, forKey: "WalkThrough")
                }
                
            } else {
                if UserDefaults.standard.bool(forKey: "WalkThrough") == true {
                    dismiss(animated: true, completion: nil)
                } else {
                    let MainViewController = BananaViewController.init()
                    let NV = UINavigationController.init(rootViewController: MainViewController)
                    NV.modalPresentationStyle = .fullScreen
                    present(NV, animated: true, completion: nil)
                    //UserDefaultsにtrueを保持させる
                    UserDefaults.standard.set(true, forKey: "WalkThrough")
                }
            }
        }
}
