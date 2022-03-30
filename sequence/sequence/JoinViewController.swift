//
//  JoinViewController.swift
//  sequence


import UIKit
import KakaoSDKAuth
import Alamofire


class JoinViewController: UIViewController {
    
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var PhoneNumTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var pwcheckTextField: UITextField!

    @IBOutlet weak var pwcheckLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emailTextField.delegate = self
        nameTextField.delegate = self
        PhoneNumTextField.delegate = self
        emailTextField.delegate = self
        pwcheckTextField.delegate = self
        
        pwcheckLabel.text = ""
        
    }
    
    @IBAction func onBtnJoin(_ sender: Any) {
        
        let data = [
                    "email": self.emailTextField.text!,
                    "password": self.emailTextField.text!,
                    "phoneNumber": self.PhoneNumTextField.text!,
                    "name": self.nameTextField.text!
                ]
        
                // API 호출
                        let url = "http://localhost:8879/auth/register"
                        let dataRequest = AF.request(url, method: .post, parameters: data, encoding: JSONEncoding.default)
                        // 서버 응답 처리
                            dataRequest.responseData{ response in
                                switch response.result {
                                        case .success:
                                    let complete = UIAlertController(title: "", message: "가입이 완료되었습니다", preferredStyle: .alert)
                                    self.present(complete, animated: true)
                                        case let .failure(error):
                                    let fail = UIAlertController(title: "오류", message: "가입에 실패하였습니다", preferredStyle: .alert)
                                    self.present(fail, animated: true)
                                            print(error)
                                        }
                                }
    
        }
    
        

    @IBAction func onBtnKakaoLogin(_ sender: UIButton) {
    }
    
}
    

    

extension JoinViewController: UITextFieldDelegate {
    
    func setLabelPasswordConfirm(_ password: String, _ passwordCheck: String)  {
        
        guard passwordCheck != "" else {
            pwcheckLabel.text = ""
            return
        }
        
        
        if password == passwordCheck {
            pwcheckLabel.textColor = .green
            pwcheckLabel.text = "패스워드가 일치합니다."
        } else {
            pwcheckLabel.textColor = .red
            pwcheckLabel.text = "패스워드가 일치하지 않습니다."
        }
    }
    
   
    // 키보드의 리턴(엔터) 키를 눌렀을 때 취해야 할 동작을 지정
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        switch textField {
            
        case emailTextField:
            nameTextField.becomeFirstResponder()
            //다음 필드인 네임 필드에 포커스
        case nameTextField:
            PhoneNumTextField.becomeFirstResponder()
            //다음 필드인 전화번호 필드에 포커스
        case PhoneNumTextField:
            passwordTextField.becomeFirstResponder()
            //다음 필드인 패스워드 필드에 포커스
        case passwordTextField:
            pwcheckTextField.becomeFirstResponder()
            //다음 필드인 패스워드재확인 필드에 포커스
        default:
            textField.resignFirstResponder()
            //현재 텍스트 필드에 대한 키보드를 사라지게 합니다.
        }
        
        return false
    }
    
    // 키보드에서 사용자가 키 하나를 눌렀을 때 취해야 할 동작을 지정
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
            if textField == pwcheckTextField {
                guard let password = passwordTextField.text,
                      let passwordCheckBefore = pwcheckTextField.text else {
                    return true
                }
                let passwordCheck = string.isEmpty ? passwordCheckBefore : passwordCheckBefore + string
                setLabelPasswordConfirm(password, passwordCheck)
                
            }
            return true
        }
    }





