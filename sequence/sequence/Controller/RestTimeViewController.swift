//
//  RestTimeViewController.swift
//  sequence
//
//  Created by 윤소희 on 2022/06/03.
//

import UIKit

class RestTimeViewController: UIViewController {

    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var timerButton: UIButton!
    var secondsLeft: Int = 300
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
        self.secondsLeft = 300
        self.updateTimerLabel()
    }
    
    @IBAction func onTimerBtn(_ sender: UIButton) {
        if timer != nil {
            resetTimer()
            return
        }
        self.timerButton.titleLabel?.font = UIFont.systemFont(ofSize: 30)
        self.timerButton.setTitle("타이머 종료하기", for: .normal)
        self.updateTimeLeft()
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { (t) in
            self.secondsLeft -= 1
            self.updateTimerLabel()
            if self.secondsLeft == 0 {
                self.resetTimer()
            }
        }
    }
}
