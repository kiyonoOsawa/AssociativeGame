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
        
    }
    
    func walkThrough() {
        let page1 = EAIntroPage()
        let page2 = EAIntroPage()
        let page3 = EAIntroPage()
        let page4 = EAIntroPage()
        let page5 = EAIntroPage()
        let page6 = EAIntroPage()
        let page7 = EAIntroPage()
        page1.bgColor = UIColor(named: "BackColor")
        page2.bgColor = UIColor(named: "BackColor")
        page3.bgColor = UIColor(named: "BackColor")
        page4.bgColor = UIColor(named: "BackColor")
        page5.bgColor = UIColor(named: "BackColor")
        page6.bgColor = UIColor(named: "BackColor")
        page7.bgColor = UIColor(named: "BackColor")
        
        //ipadの場合の処理
        if UIDevice.current.userInterfaceIdiom == .pad {
            page1.bgImage = UIImage(named: "ipad_1")
            page2.bgImage = UIImage(named: "ipad_2")
            page3.bgImage = UIImage(named: "ipad_3")
            page4.bgImage = UIImage(named: "ipad_4")
            page5.bgImage = UIImage(named: "ipad_5")
            page6.bgImage = UIImage(named: "ipad_6")
            page7.bgImage = UIImage(named: "ipad_7")
        } else {
            page1.bgImage = UIImage(named: "iphone_1")
            page2.bgImage = UIImage(named: "iphone_2")
            page3.bgImage = UIImage(named: "iphone_3")
            page4.bgImage = UIImage(named: "iphone_4")
            page5.bgImage = UIImage(named: "iphone_5")
            page6.bgImage = UIImage(named: "iphone_6")
            page7.bgImage = UIImage(named: "iphone_7")
        }
        let boundSize: CGSize = UIScreen.main.bounds.size
        let width = boundSize.width
        if width > 767 {
            page1.bgImage = UIImage(named: "ipad_1")
            page2.bgImage = UIImage(named: "ipad_2")
            page3.bgImage = UIImage(named: "ipad_3")
            page4.bgImage = UIImage(named: "ipad_4")
            page5.bgImage = UIImage(named: "ipad_5")
            page6.bgImage = UIImage(named: "ipad_6")
            page7.bgImage = UIImage(named: "ipad_7")
        } else {
            page1.bgImage = UIImage(named: "iphone_1")
            page2.bgImage = UIImage(named: "iphone_2")
            page3.bgImage = UIImage(named: "iphone_3")
            page4.bgImage = UIImage(named: "iphone_4")
            page5.bgImage = UIImage(named: "iphone_5")
            page6.bgImage = UIImage(named: "iphone_6")
            page7.bgImage = UIImage(named: "iphone_7")
        }
        let introView = EAIntroView(frame: self.view.bounds, andPages: [page1, page2, page3, page4, page5, page6, page7])
        introView?.skipButton.setTitleColor(UIColor.black, for: UIControl.State.normal)
        introView?.pageControl.pageIndicatorTintColor = UIColor.gray
        introView?.pageControl.currentPageIndicatorTintColor = UIColor.black
        introView?.skipButton.setTitle("スキップ", for: UIControl.State.normal)
        //スキップボタン欲しいならここで実装！
        introView?.delegate = self
        introView?.show(in: self.view, animateDuration: 1.0)
    }
    // スキップした時としなかった時で実装内容を分岐する事ができるメソッド。
    func introDidFinish(_ introView: EAIntroView!, wasSkipped: Bool) {
        if(wasSkipped) {
            // UserDefaultsで分岐している。trueの場合、メニュー画面の使い方からの遷移なのでdismissで戻る
            if UserDefaults.standard.bool(forKey: "WalkThrough") == true {
                dismiss(animated: true, completion: nil)
            } else {
                //false(初回起動時)の場合、初回起動時での遷移なのでメイン画面へ
                let initialViewController = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController()
                // アプリ全体で最初の画面をMain.Storyboardの最初の画面に変更している
                UIApplication.shared.keyWindow?.rootViewController = initialViewController
                UIApplication.shared.keyWindow?.makeKeyAndVisible()
                //UserDefaultsにtrueを保持させる
                UserDefaults.standard.set(true, forKey: "WalkThrough")
                // firstLunchでは無くなったことを保存する
                UserDefaults.standard.set(false, forKey: "firstLunch")
            }
            
        } else {
            if UserDefaults.standard.bool(forKey: "WalkThrough") == true {
                dismiss(animated: true, completion: nil)
            } else {
                let initialViewController = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController()
                // アプリ全体で最初の画面をMain.Storyboardの最初の画面に変更している
                UIApplication.shared.keyWindow?.rootViewController = initialViewController
                UIApplication.shared.keyWindow?.makeKeyAndVisible()
                //UserDefaultsにtrueを保持させる
                UserDefaults.standard.set(true, forKey: "WalkThrough")
                // firstLunchでは無くなったことを保存する
                UserDefaults.standard.set(false, forKey: "firstLunch")
            }
        }
    }
}
