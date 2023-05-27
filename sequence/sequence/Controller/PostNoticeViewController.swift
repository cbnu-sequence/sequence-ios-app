//
//  PostNoticeViewController.swift
//  sequence
//
//  Created by 윤소희 on 2022/06/06.
//

import UIKit
import Alamofire

class PostNoticeViewController: UIViewController {
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var contentTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func onBtnPost(_ sender: UIButton) {
        
        let data = [
            "content": self.contentTextView.text!,
            "title": self.titleTextField.text!,
        ]
        
        // API 호출
        let url = "\(Config.appURL)/post/notice"
        let dataRequest = AF.request(url, method: .post, parameters: data, encoding: JSONEncoding.default)
        // 서버 응답 처리
        dataRequest.validate().responseData { response in
            switch response.result {
            case .success:
                let alert = UIAlertController(title: "", message: "등록되었습니다.", preferredStyle: .alert)
                
                //                                    let okay = UIAlertAction(title: "확인", style: .destructive, handler: {
                //                                        action in
                //                                        let tapVC = self.storyboard?.instantiateViewController(withIdentifier: "NoticeViewController")
                //                                        tapVC?.modalPresentationStyle = .fullScreen //전체화면으로 보이게 설정
                //                                        tapVC?.modalTransitionStyle = .crossDissolve //전환 애니메이션 설정
                //                                                self.present(tapVC!, animated: true, completion: nil)
                //                                    })
                //                                    alert.addAction(okay)
                //                                    self.present(alert, animated: true)
                let okay = UIAlertAction(title: "확인", style: .default, handler: nil)
                alert.addAction(okay)
                self.present(alert, animated: true)
                
            case let .failure(error):
                let fail = UIAlertController(title: "오류", message: "등록에 실패하였습니다", preferredStyle: .alert)
                let okay = UIAlertAction(title: "확인", style: .default, handler: nil)
                fail.addAction(okay)
                self.present(fail, animated: true)
                print(error)
            }
        }
    }
}
