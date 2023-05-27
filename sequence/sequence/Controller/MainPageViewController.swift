//
//  MainPageViewController.swift
//  sequence
//
//  Created by 윤소희 on 2022/04/02.
//

import UIKit
import SafariServices

class MainPageViewController: UIViewController, UITabBarControllerDelegate {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func routingGithub(_ sender: UIButton) {
        let githubUrl = NSURL(string: "https://github.com/cbnu-sequence")
        let githubSafariView: SFSafariViewController = SFSafariViewController(url: githubUrl as! URL)
        self.present(githubSafariView, animated: true, completion: nil)
    }
}


