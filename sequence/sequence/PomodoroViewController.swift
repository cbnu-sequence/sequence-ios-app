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
    @IBOutlet weak var workTextField: UITextField!
    //var pomodoroResponse: Array<PomodoroStartData> = []
    
    var secondsLeft: Int = 10
    var timer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.updateTimeLeft()

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
            self.secondsLeft = 10
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
                
                let title : String = ""
                let pomodoroStartDate = currentTime()

                
                let pomodoroStartData = ["title": self.workTextField.text,
                                    "date": pomodoroStartDate] as [String : Any]
                // 요기에 제목이랑 현재시각 보내기
        
        // API 호출
                let url = "http://localhost:8879/pomodoro"
                let dataRequest = AF.request(url, method: .post, parameters: pomodoroStartData, encoding: JSONEncoding.default)
                // 서버 응답 처리
                dataRequest.validate().responseData { response in
                        switch response.result {
                                case .success(let obj):
                            do {
                                let dataJSON = try JSONSerialization.data(withJSONObject:obj, options: .prettyPrinted)
                                let getData = try JSONDecoder().decode(PomodoroResponse.self, from: dataJSON)
                                print(getData)
                             //   var pomodoroResponse : PomodoroResponse = getData.data
                                
                                
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
                        
//                        let pomodoroEndDate = self.currentTime()
//                        let id = pomodoroResponse
//
//                        let pomodoroEndData = ["date": pomodoroEndDate] as [String : Any]
//                        // 요기에 제목이랑 현재시각 보내기
//
//                // API 호출
//                        let url = "http://localhost:8879/pomodoro/ "
//                        let dataRequest = AF.request(url, method: .post, parameters: pomodoroEndData, encoding: JSONEncoding.default)
//                        // 서버 응답 처리
//                        dataRequest.validate().responseData { response in
//                                switch response.result {
//                                        case .success:
//                                    print("success")
//                                        case let .failure(error):
//                                            print(error)
//                                        }
//                                }
                        
                        //요기에 서버에 현재시각 보내기
                        
                    }
                }
            }
        
    
    @IBAction func onBtnShowPomodoro(_ sender: UIButton) {
    }

}
    


