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
    
    @IBAction func onBtnResend(_ sender: UIButton) {
        let url = "\(Config.appURL)/auth/mail"
        let dataRequest = AF.request(url, method: .post, encoding: JSONEncoding.default)
        // 서버 응답 처리
        dataRequest.validate().responseData { response in
            switch response.result {
            case .success:
                let resend = UIAlertController(title: "", message: "메일이 재전송되었습니다.", preferredStyle: .alert)
                let okay = UIAlertAction(title: "확인", style: .default, handler:nil)
                resend.addAction(okay)
                self.present(resend, animated: true)
                
            case let .failure(error):
                print(error)
            }
        }
    }
    
    @IBAction func onBtnComplete(_ sender: UIButton) {
        
        let token = ["token":self.certificationNumTextField.text!]
        
        let url = "\(Config.appURL)/auth/valid"
        let dataRequest = AF.request(url, method: .post, parameters: token, encoding: JSONEncoding.default)
        // 서버 응답 처리
        dataRequest.validate().responseData { response in
            switch response.result {
            case .success:
                let complete = UIAlertController(title: "", message: "가입이 완료되었습니다", preferredStyle: .alert)
                let okay = UIAlertAction(title: "확인", style: .destructive, handler: {
                    action in
                    let tapVC = self.storyboard?.instantiateViewController(withIdentifier: "maintapcontroller")
                    tapVC?.modalPresentationStyle = .fullScreen //전체화면으로 보이게 설정
                    tapVC?.modalTransitionStyle = .crossDissolve //전환 애니메이션 설정
                    self.present(tapVC!, animated: true, completion: nil)
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
