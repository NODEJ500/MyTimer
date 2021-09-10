//
//  ViewController.swift
//  MyTimer
//
//  Created by Jun on 2021/09/09.
//

import UIKit

class ViewController: UIViewController {

    //タイマー変数の作成
    var timer: Timer?
    //カウント（経過時間）の変数を作成
    var count = 0
    //設定値を扱うキーを設定
    let settingKey = "timer_value"
                                                                                                                  
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //UserDefaultsのインスタンスを作成
        let setting = UserDefaults.standard
        //UserDefaultsに初期値を登録
        setting.register(defaults: [settingKey:10])
        
      
        
        
    }

    @IBOutlet weak var countDownLabel: UILabel!
    
    
    @IBAction func settingButtonAction(_ sender: Any) {
        
        
    }
    
    
    @IBAction func startButtonAction(_ sender: Any) {
    }
    
    
    @IBAction func stopButtonAction(_ sender: Any) {
    }
    
    func displayUpdate() -> Int{
        
        //UserDefaultsのインスタンスを作成
        let setting = UserDefaults.standard
        //取得した秒数をtimerValueに渡す
        let taimerValue = setting.integer(forKey: settingKey)
        //残り時間（remainCount）を生成
        let remainCount = taimerValue - count
        //remainCount(残り時間)をラベルに表示
        countDownLabel.text = "残り\(remainCount)秒"
        //残り時間を戻り値に設定
        return remainCount
        
    }
    
}

