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
        let page1 = EAIntroPage()
        //画像の設定
        page1.bgImage = UIImage(named: "iphone_1")
        //ここでページを追加
        let introView = EAIntroView(frame: self.view.bounds, andPages: [page1])
        //スキップボタンのテキスト
        introView?.skipButton.setTitle("スキップ", for: UIControl.State.normal)
        //スキップボタンの色変更
        introView?.skipButton.setTitleColor(UIColor.white, for: UIControl.State.normal)
        introView?.delegate = self
        //アニメーション設定
        introView?.show(in: self.view, animateDuration: 0.5)
    }
}
