//
//  NoticeViewController.swift
//  sequence
//
//  Created by 윤소희 on 2022/04/14.
//

import UIKit
import KakaoSDKAuth
import Alamofire
import KakaoSDKCommon
import KakaoSDKUser

class NoticeViewController: UIViewController {
    
    
    
    public var page = 1
   // public let notices = [Notice]()
    
    
    @IBOutlet weak var noticeTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

     
    }
    
//    func getNoticeData() {
//
//      // var page = 1
//       let hashPage = ["page":page]
//
//   let url = "http://localhost:8879/post/notice"
//   let dataRequest = AF.request(url, method: .get, parameters: hashPage, encoding: JSONEncoding.default)
//   // 서버 응답 처리
//   dataRequest.validate().responseData { response in
//           switch response.result {
//                   case .success:
//               notices.append(response.data)
//                   case let .failure(error):
//                               print("error")
//                       }
//           print("get요청 결과\(response)")
//           }
//   }
}
    
    
    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//
//
//        return cell
//    }
//
    




extension NoticeViewController : UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let contentOffset_y = scrollView.contentOffset.y
        let tableViewContentSize = noticeTableView.contentSize.height
        let pagination_y = tableViewContentSize * 0.2
        
        if contentOffset_y > tableViewContentSize - pagination_y {
            
            
                    
                }
                
            }
            
        }
        
    
    

