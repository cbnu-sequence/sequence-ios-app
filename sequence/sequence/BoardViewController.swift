//
//  BoardViewController.swift
//  sequence
//
//  Created by 윤소희 on 2022/04/14.
//

import UIKit
import Tabman
import Pageboy


class BoardViewController: TabmanViewController {

    private var vcArr: Array<UIViewController> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let vc2 = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ShareInfoViewController") as! ShareInfoViewController
                let vc3 = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ProjectViewController") as! ProjectViewController
                    
                vcArr.append(vc2)
                vcArr.append(vc3)
                
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
    
}

extension BoardViewController: PageboyViewControllerDataSource, TMBarDataSource {
    func barItem(for bar: TMBar, at index: Int) -> TMBarItemable {
        
        switch index {
                case 0:
                    return TMBarItem(title: "정보 공유")
                case 1:
                    return TMBarItem(title: "프로젝트 소개")
                default:
                    let title = "Page \(index)"
                    return TMBarItem(title: title)
                }

    }
    
    func numberOfViewControllers(in pageboyViewController: PageboyViewController) -> Int {
        return vcArr.count
    }

    func viewController(for pageboyViewController: PageboyViewController,
                        at index: PageboyViewController.PageIndex) -> UIViewController? {
        return vcArr[index]
    }

    func defaultPage(for pageboyViewController: PageboyViewController) -> PageboyViewController.Page? {
        return nil
    }
}
    

