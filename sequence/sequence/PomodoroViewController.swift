//
//  PomodoroViewController.swift
//  sequence
//
//  Created by 윤소희 on 2022/04/14.
//

import UIKit
import KakaoSDKAuth
import Alamofire
import KakaoSDKCommon
import KakaoSDKUser


class PomodoroViewController: UIViewController {
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var timerButton: UIButton!
    @IBOutlet weak var showPomodoroBtn: UIButton!
    @IBOutlet weak var pomodoroRankingBtn: UIButton!
    @IBOutlet weak var workTextField: UITextField!
    @IBOutlet weak var alertLabel: UILabel!
    var id: String = ""
    
    var secondsLeft: Int = 1500
    var timer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.updateTimeLeft()
        self.buttonLayout(isOn: false)
       

    }
    
    func resetTimer() {
            let minutes = 0
            let seconds = 0
            timer?.invalidate()
            timeLabel.text = String(format: "%02d:%02d", minutes, seconds)
            timer = nil
            timerButton.setTitle("타이머 시작하기", for: .normal)
            timerButton.titleLabel!.font = UIFont.systemFont(ofSize: 50)
        }

        func updateTimerLabel() {
            
            var minutes = self.secondsLeft / 60
            var seconds = self.secondsLeft % 60


            UIView.transition(with: self.timeLabel, duration: 0.3, options: .transitionFlipFromBottom) {
                if self.secondsLeft > 0 {
                    self.timeLabel.text = String(format: "%02d:%02d", minutes, seconds)
                } else {
                    self.timeLabel.text = "시간 끝"
                }
            } completion: { (animated) in

            }
        }

        func updateTimeLeft() {
            self.secondsLeft = 1500
            self.updateTimerLabel()
        }
    
    func currentTime() -> String {
        
        let now = Date()
        let formatter = DateFormatter()
        //한국 시간으로 표시
        formatter.locale = Locale(identifier: "ko_kr")
        formatter.timeZone = TimeZone(abbreviation: "KST")
        //형태 변환
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        return formatter.string(from: now)
        
    }
    

    
    
    @IBAction func onBtnTimer(_ sender: UIButton) {
        
        if timer != nil {
                    resetTimer()
                    return
                }
                
                
                let pomodoroStartDate = currentTime()
        
                let pomodoroStartData = ["title": self.workTextField.text,
                                    "date": pomodoroStartDate] as [String : Any]

        
        // API 호출
                let url = "\(Config.appURL)/pomodoro"
                let dataRequest = AF.request(url, method: .post, parameters: pomodoroStartData, encoding: JSONEncoding.default)
                // 서버 응답 처리
                dataRequest.validate().responseJSON { response in
                        switch response.result {
                                case .success(let obj):
                            do {
                                let dataJSON = try JSONSerialization.data(withJSONObject:obj, options: .prettyPrinted)
                                let getData = try JSONDecoder().decode(PomodoroResponse.self, from: dataJSON)
                            
                                var pomodoroResponse: PomodoroStartData = getData.data
                                
                                self.id = (pomodoroResponse._id)!
                                print(self.id)
                                
                            } catch(let error) {
                                print(error)
                            }

                                case let .failure(error):
                                    print(error)
                                }
                        }
                
                
                self.timerButton.titleLabel?.font = UIFont.systemFont(ofSize: 30)
                self.timerButton.setTitle("타이머 종료하기", for: .normal)

                self.updateTimeLeft()


                timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { (t) in
                    self.secondsLeft -= 1
                    self.updateTimerLabel()

                    if self.secondsLeft == 0 {
                        self.resetTimer()
                        
                        let pomodoroEndDate = self.currentTime()
                        

                        let pomodoroEndData = ["date": pomodoroEndDate] as [String : Any]


                // API 호출
                        let url = "\(Config.appURL)/pomodoro/\(self.id)"
                        let dataRequest = AF.request(url, method: .post, parameters: pomodoroEndData, encoding: JSONEncoding.default)
                        // 서버 응답 처리
                        dataRequest.validate().responseData { response in
                                switch response.result {
                                        case .success:
                                    print("success")
                                        case let .failure(error):
                                            print(error)
                                        }
                                }

                    }
                }
            }
        
    
    @IBAction func onBtnShowPomodoro(_ sender: UIButton) {
    }
    

    @IBAction func editChanged(_ sender: UITextField) {
        
        if sender.text?.isEmpty == true {
            self.buttonLayout(isOn: false)
  
        } else {
            self.buttonLayout(isOn: true)
        }
    }
    
    func buttonLayout(isOn: Bool) {
        switch isOn {
        case true:
            timerButton.isUserInteractionEnabled = true
            alertLabel.text = ""

        case false:
            timerButton.isUserInteractionEnabled = false
            alertLabel.textColor = .red
            alertLabel.text = "25분동안 할 일을 입력해주세요."
   
        }
    
    }
    
}


