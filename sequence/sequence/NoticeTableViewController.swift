//
//  NoticeTableViewController.swift
//  sequence
//
//  Created by 윤소희 on 2022/05/16.
//

import UIKit
import KakaoSDKAuth
import Alamofire
import KakaoSDKCommon
import KakaoSDKUser

class NoticeTableViewController: UITableViewController {

    let arr = [1, 2, 3]
public var page = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()

        getNoticeData()
        
    }
    
     func getNoticeData() {
    
       // var page = 1
        let hashPage = ["page":page]
    
    let url = "http://localhost:8879/post/notice"
    let dataRequest = AF.request(url, method: .get, parameters: hashPage, encoding: JSONEncoding.default)
    // 서버 응답 처리
    dataRequest.validate().responseData { response in
            switch response.result {
                    case .success:print("sucess")
                //let notices : [Notice] =
                
                
                    case let .failure(error):
                        
                                print("error")
                        }
            print("get요청 결과\(response)")
            }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        getNoticeData()
    }
     

    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return arr.count
    }

    
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "NoticeCell", for: indexPath)
//
//       // guard indexPath.row < self.arr.count else { return cell }
//
//       // let arr = self.todos[indexPath.row]
//
//        // 셀에 내용 설정
//        cell.textLabel?.text = todo.title
//        cell.detailTextLabel?.text = self.dateFormatter.string(from: todo.due)
//
//        return cell
//
//        return cell
//    }
//

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
