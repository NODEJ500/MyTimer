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
        //timerをアンラップしてnowTimerに代入
        if let nowTimer = timer {
            //もしタイマーが実行中だったら停止
            if nowTimer.isValid == true {
                //タイマー停止
                nowTimer.invalidate()
            }
        }
        //画面遷移を行う
        performSegue(withIdentifier: "goSetting", sender: nil)
    }
    @IBAction func startButtonAction(_ sender: Any) {
        //timerをアンラップしてnowTimerに代入
        if let nowTimar = timer {
            //もしタイマーが実行中だったらスタートしない
            if nowTimar.isValid == true {
                //何も処理しない
                return
            }
        }
        //タイマーをスタート
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.timerInterrupt(_:)), userInfo: nil, repeats: true)
    }
    @IBAction func stopButtonAction(_ sender: Any) {
        //timerをアンラップしてnowTimerに代入
        if let nowTimer = timer {
            //もしタイマーが、実行中だったら停止
            if nowTimer.isValid == true {
                //タイマー停止
                nowTimer.invalidate()
            }
        }
    }
    
    //画面を更新する（戻り値:remainCount:残り時間）
    func displayUpdate() -> Int {
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
    
    @objc func timerInterrupt(_ timer:Timer) {
        //count(経過時間)に+1していく
        count += 1
        //remianCount(残り時間)が0以下の時、タイマーを止める
        if displayUpdate() <= 0 {
            //初期化処理
            count = 0
            //タイマー停止
            timer.invalidate()
            
            //カスタマイズ編：ダイアログを作成
            let alertController = UIAlertController(title: "終了",message: "タイマー終了時間です",preferredStyle: .actionSheet)
            //ダイアログに表示させるOKボタンを作成
            let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            //アクションを追加
            alertController.addAction(defaultAction)
            //ダイアログの表示
            present(alertController, animated: true, completion: nil)
        }
    }
    //画面切り替えのタイミングで処理を行う
    override func viewDidAppear(_ animated: Bool) {
        //カウント（経過時間）をゼロにする
        count = 0
        //タイマーの表示を更新する
        _ = displayUpdate()
    }
}

