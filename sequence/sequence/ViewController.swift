//
//  ViewController.swift
//  sequence
//
//  Created by 윤소희 on 2022/03/15.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var textfieldID: UITextField!
    
    @IBOutlet weak var texifieldPW: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func onBtnLogin(_ sender: UIButton) {
        
        if let textID = textfieldID.text, let textPW = texifieldPW.text {
            
            if textID.count < 3 || textPW.count < 3 {
                print("아이디나 암호의 길이를 확인해주세요.")
                return
            }
        }
    }
    
    
    @IBAction func onBtnJoin(_ sender: UIButton) {
    }
    
}

