//
//  ShowNoticeViewController.swift
//  sequence
//
//  Created by 윤소희 on 2022/05/20.
//

import UIKit

class ShowNoticeViewController: UIViewController {
    

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var writerLabel: UILabel!
    @IBOutlet weak var contentTextView: UITextView!
    @IBOutlet weak var dateLabel: UILabel!
    
    var noticeData: [Notice] = []
    var titletext: String = ""
    var nametext: String = ""
    var contenttext: String = ""
    var datetext: String = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel?.text = " \(titletext)"
        writerLabel?.text = "작성자: \(nametext)"
        contentTextView?.text = (contenttext)
        dateLabel?.text = datetext
        
        
      //  lineSpacingFunc()

        
    }
    
    func lineSpacingFunc() {
    

        let attrString = NSMutableAttributedString(string: contentTextView.text!)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 4
        attrString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, attrString.length))
        contentTextView.attributedText = attrString
      
    }
    

}


