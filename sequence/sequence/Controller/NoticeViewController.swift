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
import SwiftUI

class NoticeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var page = 1
    var noticeData: Array<Notice> = []
    var fetchingMore : Bool = false
    var sliced_createdAt: String = ""
    
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
        noticeData.removeAll()
        getNoticeData()
    }
    
    func getNoticeData() {
        let url = "\(Config.appURL)/post/notice?sort=-createdAt&page=\(page)&limit=20"
        let header : HTTPHeaders = ["Content-Type": "application/json"]
        let dataRequest = AF.request(url, method: .get, encoding: JSONEncoding.default, headers: header)
        // 서버 응답 처리
        dataRequest.validate().responseJSON { (response) in
            switch response.result {
            case .success(let obj):
                do {
                    let dataJSON = try JSONSerialization.data(withJSONObject:obj, options: .prettyPrinted)
                    let getData = try JSONDecoder().decode(APIResponse.self, from: dataJSON)
                    
                    for i in 0 ..< getData.data.count {
                        self.noticeData.append(getData.data[i])
                    }
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
        
        //배포하기 전에 여기 한번 더 신경쓰기
        if notice != nil {
            let createdAtStr = notice.createdAt
            let startIndex = createdAtStr!.index(createdAtStr!.startIndex, offsetBy: 0)
            let endIndex = createdAtStr!.index(createdAtStr!.startIndex, offsetBy: 10)
            self.sliced_createdAt = String(createdAtStr![startIndex ..< endIndex])
            
            cell.dateLabel?.text = String(sliced_createdAt)
            cell.titleLabel.text = notice.title
        } else {
            print("nil")
        }
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
        vc.datetext = String(sliced_createdAt)
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if noticeTableView.contentOffset.y > (noticeTableView.contentSize.height - noticeTableView.bounds.size.height) {
            if !fetchingMore {
                beginBatchFetch()
            }
        }
    }
    
    private func beginBatchFetch() {
        fetchingMore = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.7, execute: {
            self.page += 1
            self.getNoticeData()
            self.fetchingMore = false
            self.noticeTableView.reloadData()
        })
    }
}






