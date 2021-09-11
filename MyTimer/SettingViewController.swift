//
//  SettingViewController.swift
//  MyTimer
//
//  Created by Jun on 2021/09/09.
//

import UIKit

class SettingViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate{
   
    
    
    //UIPickerViewに表示するデータをArrayで作成
    let settingArrray : [Int] = [10,20,30,40,50,60]
    //設定値を覚えるキーを設定
    let settingKey = "timer_value"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //timarSettingPickerのデリゲートとデータソースの通知先を設定
        timerSettingPicker.delegate = self
        timerSettingPicker.dataSource = self
        
        //UserDefaultsの取得
        let settings = UserDefaults.standard
        let timerValue = settings.integer(forKey: settingKey)

        //UsrePickerの選択を合わせる
        for row in 0..<settingArrray.count {
            if settingArrray[row] == timerValue{
                timerSettingPicker.selectRow(row, inComponent: 0, animated: true)
            }
            
            
        }
        
       
    }
    
    @IBOutlet weak var timerSettingPicker: UIPickerView!
    
    @IBAction func decisionButtonAction(_ sender: Any) {
        //前画面に戻る
        _ = navigationController?.popViewController(animated: true)
    }
    
    //UIPickerViewの列数を設定
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    //UIPickerViewの行数を設定
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        settingArrray.count
    }
    //UIPickerViewの表示する内容を設定
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return String(settingArrray[row])
    }
    
    //picker選択時に実行
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        //UserDefaultsの設定
        let settings = UserDefaults.standard
        settings.setValue(settingArrray[row], forKey: settingKey)
        settings.synchronize()
        
    }
}
