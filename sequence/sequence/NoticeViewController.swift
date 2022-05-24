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

class NoticeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    

    
    var page = 1
    var noticeData: [Notice] = []
    var fetchingMore: Bool = false
    
    
    @IBOutlet weak var noticeTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 테이블 뷰의 일반 이벤트 처리
        noticeTableView.delegate = self
        // 테이블 뷰의 데이터소스 처리
        noticeTableView.dataSource = self
     
        

     
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        getNoticeData()
    }
    
    func getNoticeData() {

   
   let url = "http://localhost:8879/post/notice?page=\(page)"
   let header : HTTPHeaders = ["Content-Type": "application/json"]
   let dataRequest = AF.request(url, method: .get, encoding: JSONEncoding.default, headers: header)
   // 서버 응답 처리
        dataRequest.validate().responseJSON { (response) in
           switch response.result {
                   case .success(let obj):
               do {
                   let dataJSON = try JSONSerialization.data(withJSONObject:obj, options: .prettyPrinted)
                   let getData = try JSONDecoder().decode(APIResponse.self, from: dataJSON)
                   DispatchQueue.main.async {
                       self.noticeTableView.reloadData()
                   }
                   
               } catch(let error) {
                   print(error)
               }
           case .failure(let error) :
               print(error)
           }

           }
   }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.noticeData.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = self.noticeTableView.dequeueReusableCell(withIdentifier: "NoticeCell", for: indexPath) as! NoticeTableViewCell
        
        let notice: Notice = self.noticeData[indexPath.row]
        cell.dateLabel?.text = notice.createdAt
        cell.titleLabel.text = notice.title


        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) { //클릭한 셀의 이벤트 처리
        
        guard let vc =  storyboard?.instantiateViewController(identifier: "ShowNoticeViewController") as? ShowNoticeViewController else
        { return }
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        
        let notice: Notice = self.noticeData[indexPath.row]
        
        vc.titletext = notice.title!
        vc.nametext = (notice.writer?.name)!
        vc.contenttext = notice.content!
        vc.datetext = notice.createdAt!
        
        self.navigationController?.pushViewController(vc, animated: true)
    
    
    }

}
  

extension NoticeViewController : UIScrollViewDelegate {

    func scrollViewDidScroll(_ scrollView: UIScrollView) {

        let contentOffset_y = scrollView.contentOffset.y
        let tableViewContentSize = noticeTableView.contentSize.height
        let pagination_y = tableViewContentSize * 0.2

        if contentOffset_y > tableViewContentSize - pagination_y {
            
            page += 1
            getNoticeData()

                }

            }

        }
        
    
    

