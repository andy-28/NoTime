//
//  ViewController.swift
//  NoTime
//
//  Created by 江啟綸 on 2022/1/20.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var addBtn: UIButton! {
        didSet {
            addBtn.layer.borderWidth = 3
            addBtn.layer.borderColor = UIColor.white.cgColor
            addBtn.layer.cornerRadius = 10
        }
    }
    @IBOutlet weak var TimeStackBig: UIStackView!
    @IBOutlet weak var TimeStack: UIStackView!
    @IBOutlet weak var DatePicker: UIDatePicker!
    @IBOutlet weak var goalTextfield: UITextField!
    
    @IBOutlet weak var mthLabel: UILabel!
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var hrsLabel: UILabel!
    @IBOutlet weak var minLabel: UILabel!
    @IBOutlet weak var secLabel: UILabel!
    @IBOutlet weak var resetBtn: UIButton! {
        didSet {
            resetBtn.layer.borderWidth = 1
            resetBtn.layer.borderColor = UIColor.red.cgColor
            resetBtn.layer.cornerRadius = 10
        }
    }
    
    @IBOutlet weak var dateTF: UITextField!
    
    
    var timer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        resetBtn.isHidden = true
        
    }
    
    
    @IBAction func addBtnPressed(_ sender: UIButton) {
        
        if goalTextfield.text == "" {
            let alert = UIAlertController(title: "Title", message: "Input Goal", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (_) in
                
            }))
            
            self.present(alert, animated: true, completion: nil)
        }
        else {
            
            let dueDate = DatePicker.date
            
            timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [self] (_) in
                
                let interval = Int(dueDate.timeIntervalSinceNow)
                let mth = interval / (60 * 60 * 24 * 30)
                let day = interval / (60 * 60 * 24) % 30
                let hrs = interval / (60 * 60) % 24
                let min = interval / 60 % 60
                let sec = interval % 60
                
                
                let numberFormatter = NumberFormatter()
                numberFormatter.formatWidth = 2
                numberFormatter.paddingCharacter = "0"
                
                mthLabel.text = numberFormatter.string(from: NSNumber(value: mth))
                dayLabel.text = numberFormatter.string(from: NSNumber(value: day))
                hrsLabel.text = numberFormatter.string(from: NSNumber(value: hrs))
                minLabel.text = numberFormatter.string(from: NSNumber(value: min))
                secLabel.text = numberFormatter.string(from: NSNumber(value: sec))
            }
            addBtn.isHidden = true
            DatePicker.isHidden = true
            resetBtn.isHidden = false
        }
        
    }
    @IBAction func resetBtnPressed(_ sender: UIButton) {
        let alert = UIAlertController(title: "Reset Timer?", message: "Are you sure you would like to reset the Timer?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "CANCEL", style: .cancel, handler: { (_) in
            //do nothing
        }))
        
        alert.addAction(UIAlertAction(title: "YES", style: .default, handler: { (_) in
            self.mthLabel.text = "00"
            self.dayLabel.text = "00"
            self.hrsLabel.text = "00"
            self.minLabel.text = "00"
            self.secLabel.text = "00"
            self.goalTextfield.text = ""
            self.timer?.invalidate()
            self.addBtn.isHidden = false
            self.DatePicker.isHidden = false
            
            self.resetBtn.isHidden = true
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    
}

