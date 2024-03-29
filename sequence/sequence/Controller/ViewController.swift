//
//  ViewController.swift
//  sequence
//
//  Created by 윤소희 on 2022/03/15.
//

import UIKit
import KakaoSDKAuth
import Alamofire
import KakaoSDKCommon
import KakaoSDKUser

class ViewController: UIViewController {
    
    //아이디와 비밀번호를 입력하는 창 아웃렛 변수로 연결
    @IBOutlet weak var textfieldID: UITextField!
    @IBOutlet weak var textfieldPW: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //이벤트가 발생했을때 누가 수행 -> self
        textfieldID.delegate = self
        textfieldPW.delegate = self
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            self.view.endEditing(true)
        }
    
    // 로그인 버튼 눌렀을때 실행되는 코드 (액션함수)
    @IBAction func onBtnLogin(_ sender: UIButton) {
        
        // 사용자의 아이디와 비밀번호 정보를 담은 배열
        let userdata = [
            "email": self.textfieldID.text!,
            "password": self.textfieldPW.text!
        ]
        
        // API 호출
        let url = "\(Config.appURL)/auth/login"
        let dataRequest = AF.request(url, method: .post, parameters: userdata, encoding: JSONEncoding.default)
        // 서버 응답 처리
        dataRequest.validate().responseData { response in
            switch response.result {
            case .success:
                let mainpageView = self.storyboard?.instantiateViewController(withIdentifier: "maintapcontroller")
                mainpageView?.modalPresentationStyle = .fullScreen //전체화면으로 보이게 설정
                mainpageView?.modalTransitionStyle = .crossDissolve //전환 애니메이션 설정
                self.present(mainpageView!, animated: true, completion: nil)
                
            case let .failure(error):
                let fail = UIAlertController(title: "", message: "로그인에 실패하였습니다", preferredStyle: .alert)
                let okay = UIAlertAction(title: "확인", style: .default, handler: nil)
                fail.addAction(okay)
                self.present(fail, animated: true)
                print(error)
            }
        }
        
    }
    
    // 카카오 로그인 버튼을 눌렀을때 실행
    @IBAction func onBtnKakaoLogin(_ sender: UIButton) {
        
        //카카오 계정으로 로그인
        UserApi.shared.loginWithKakaoAccount {(oauthToken, error) in
            
            if let error = error {
                print(error)
            }
            else {
                
                _ = oauthToken
                
                //사용자의 accessToken 을 담은 배열
                let kakaoToken = [
                    "accessToken" : oauthToken!.accessToken
                ]
                
                let url = "\(Config.appURL)/auth/kakao/login"
                let dataRequest = AF.request(url, parameters: kakaoToken, encoder: URLEncodedFormParameterEncoder.default)
                
                dataRequest.validate().response { response in
                    switch response.result {
                        
                    case let .failure(error):
                        let fail = UIAlertController(title: "오류", message: "로그인에 실패하였습니다", preferredStyle: .alert)
                        let okay = UIAlertAction(title: "확인", style: .default, handler: nil)
                        fail.addAction(okay)
                        self.present(fail, animated: true)
                        print(error)
                    case .success:
                        let mainpageView = self.storyboard?.instantiateViewController(withIdentifier: "maintapcontroller")
                        mainpageView?.modalPresentationStyle = .fullScreen //전체화면으로 보이게 설정
                        mainpageView?.modalTransitionStyle = .crossDissolve //전환 애니메이션 설정
                        self.present(mainpageView!, animated: true, completion: nil)
                        
                    }
                }
            }
        }
        
        
        //        // 카카오톡 설치 여부 확인
        //                if (UserApi.isKakaoTalkLoginAvailable()) {
        //                    UserApi.shared.loginWithKakaoTalk {(oauthToken, error) in
        //                        if let error = error {
        //                            // 예외 처리 (로그인 취소 등)
        //                            print(error)
        //                        }
        //                        else {
        //                            print("loginWithKakaoTalk() success.")
        //                            // do something
        //                            _ = oauthToken
        //                            // 어세스토큰
        //                            let accessToken = oauthToken?.accessToken
        //
        //
        //                        }
        //                    }
        //                }
    }
    
}


extension ViewController: UITextFieldDelegate {
    
    // 키보드의 리턴(엔터) 키를 눌렀을 때 취해야 할 동작을 지정
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        switch textField {
            
        case textfieldID:
            textfieldPW.becomeFirstResponder()
            //다음 필드인 네임 필드에 포커스
        default:
            textField.resignFirstResponder()
        }
        
        return false
    }
    
}



