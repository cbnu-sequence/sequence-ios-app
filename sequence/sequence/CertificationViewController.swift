//
//  CertificationViewController.swift
//  sequence
//
//  Created by 윤소희 on 2022/03/31.
//

import UIKit
import KakaoSDKAuth
import Alamofire

class CertificationViewController: UIViewController {

    @IBOutlet weak var certificationNumTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    @IBAction func onBtnSend(_ sender: UIButton) {
    }
    
    
    @IBAction func onBtnResend(_ sender: UIButton) {
    }
    
    
    @IBAction func onBtnComplete(_ sender: UIButton) {
        
        let token = ["token":self.certificationNumTextField.text!]
        
        let url = "http://localhost:8879/auth/valid"
        let dataRequest = AF.request(url, method: .post, parameters: token, encoding: JSONEncoding.default)
        // 서버 응답 처리
        dataRequest.validate().responseData { response in
                switch response.result {
                        case .success:
                            let complete = UIAlertController(title: "", message: "가입이 완료되었습니다", preferredStyle: .alert)
                            let okay = UIAlertAction(title: "확인", style: .destructive, handler: {
                                action in
                                let mainpageView = self.storyboard?.instantiateViewController(withIdentifier: "mainpageView")
                                mainpageView?.modalPresentationStyle = .fullScreen //전체화면으로 보이게 설정
                                mainpageView?.modalTransitionStyle = .crossDissolve //전환 애니메이션 설정
                                        self.present(mainpageView!, animated: true, completion: nil)
                            })
                            complete.addAction(okay)
                            self.present(complete, animated: true)
                    
                    
                        case let .failure(error):
                            let fail = UIAlertController(title: "", message: "인증번호가 올바르지 않습니다.", preferredStyle: .alert)
                            let okay = UIAlertAction(title: "확인", style: .default, handler: nil)
                            fail.addAction(okay)
                            self.present(fail, animated: true)
                                    print(error)
                            }
                print(response.result)
                }
        
    }
    
    
    
    
}
