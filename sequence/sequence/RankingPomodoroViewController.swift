//
//  RankingPomodoroViewController.swift
//  sequence
//
//  Created by 윤소희 on 2022/06/01.
//

import UIKit
import Tabman
import Pageboy

class RankingPomodoroViewController: TabmanViewController {
   
    
    
    private var pomodoroVCArr: Array<UIViewController> = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let pomodoroVC2 = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DailyPomodoroViewController") as! DailyPomodoroViewController
        let pomodoroVC3 = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "WeeklyPomodoroViewController") as! WeeklyPomodoroViewController
        let pomodoroVC4 = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MonthlyPomodoroViewController") as! MonthlyPomodoroViewController
                    
            pomodoroVCArr.append(pomodoroVC2)
            pomodoroVCArr.append(pomodoroVC3)
            pomodoroVCArr.append(pomodoroVC4)
        
                
                self.dataSource = self

                // Create bar
                let bar = TMBar.ButtonBar()
        
                // Customize
                bar.layout.transitionStyle = .snap
                bar.backgroundView.style = .blur(style: .regular)
                bar.layout.contentInset = UIEdgeInsets(top: 0.0, left: 20.0, bottom: 0.0, right: 20.0)
                

                // Add to view
                addBar(bar, dataSource: self, at: .top)

        
    }
    
    func numberOfViewControllers(in pageboyViewController: PageboyViewController) -> Int {
        return pomodoroVCArr.count
    }
    
    func viewController(for pageboyViewController: PageboyViewController, at index: PageboyViewController.PageIndex) -> UIViewController? {
        return pomodoroVCArr[index]
    }
    
    func defaultPage(for pageboyViewController: PageboyViewController) -> PageboyViewController.Page? {
        return nil
    }
    
    
}

extension RankingPomodoroViewController: PageboyViewControllerDataSource, TMBarDataSource {
    func barItem(for bar: TMBar, at index: Int) -> TMBarItemable {
        switch index {
                case 0:
                    return TMBarItem(title: "일간 랭킹")
                case 1:
                    return TMBarItem(title: "주간 랭킹")
                case 2:
                    return TMBarItem(title: "월간 랭킹")
                default:
                    let title = "Page \(index)"
                    return TMBarItem(title: title)
                }
    }
    
    
    func numberOfPomodoroViewControllers(in pageboyViewController: PageboyViewController) -> Int {
        return pomodoroVCArr.count
    }

    func PomodoroviewController(for pageboyViewController: PageboyViewController,
                        at index: PageboyViewController.PageIndex) -> UIViewController? {
        return pomodoroVCArr[index]
    }

    func defaultPomodoroPage(for pageboyViewController: PageboyViewController) -> PageboyViewController.Page? {
        return nil
    }
}
