import UIKit
import KakaoSDKAuth
import Alamofire
import KakaoSDKCommon
import KakaoSDKUser

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
        passwordTextField.delegate = self
        pwcheckTextField.delegate = self
        pwcheckLabel.text = ""
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            self.view.endEditing(true)
        }
    
    @IBAction func onBtnJoin(_ sender: Any) {
        
        let data = [
                    "email": self.emailTextField.text!,
                    "password": self.passwordTextField.text!,
                    "phoneNumber": self.PhoneNumTextField.text!,
                    "name": self.nameTextField.text!
                ]
        
                // API 호출
                let url = "\(Config.appURL)/auth/register"
                        let dataRequest = AF.request(url, method: .post, parameters: data, encoding: JSONEncoding.default)
                        // 서버 응답 처리
                        dataRequest.validate().responseData { response in
                                switch response.result {
                                        case .success:
                                    self.performSegue(withIdentifier: "showSegue", sender: sender)
                                        case let .failure(error):
                                    let fail = UIAlertController(title: "오류", message: "가입에 실패하였습니다", preferredStyle: .alert)
                                    let okay = UIAlertAction(title: "확인", style: .default, handler: nil)
                                    fail.addAction(okay)
                                    self.present(fail, animated: true)
                                            print(error)
                                        }
                                }
    
        }
    
    @IBAction func onBtnKakaoLogin(_ sender: UIButton) {
        
        UserApi.shared.loginWithKakaoAccount {(oauthToken, error) in
                if let error = error {
                    print(error)
                }
                else {
                    _ = oauthToken
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
//
//
//                        }
//                    }
//                }
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





