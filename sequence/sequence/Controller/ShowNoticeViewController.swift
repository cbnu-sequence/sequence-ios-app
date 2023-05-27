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
        contentTextView?.text = (contenttext.htmlEscaped)
        dateLabel?.text = datetext
    }
    
    func lineSpacingFunc() {
        let attrString = NSMutableAttributedString(string: contentTextView.text!)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 4
        attrString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, attrString.length))
        contentTextView.attributedText = attrString
    }
}

extension String {
    // html 태그 제거 + html entity들 디코딩.
    var htmlEscaped: String {
        guard let encodedData = self.data(using: .utf8) else {
            return self
        }
        
        let options: [NSAttributedString.DocumentReadingOptionKey: Any] = [
            .documentType: NSAttributedString.DocumentType.html,
            .characterEncoding: String.Encoding.utf8.rawValue
        ]
        
        do {
            let attributed = try NSAttributedString(data: encodedData,
                                                    options: options,
                                                    documentAttributes: nil)
            return attributed.string
        } catch {
            return self
        }
    }
}

