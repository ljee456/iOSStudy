//
//  ListViewController.swift
//  CustomCell
//
//  Created by 202 on 2021/03/02.
//

import UIKit

class ListViewController: UITableViewController {

    //디셔너리 배열을 프로퍼티로 생성
    var ar : Array<Dictionary<String, String>> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let dic1 = ["name":"제시카", "skill":"영어", "imageName":"image1.png"]
        let dic2 = ["name":"유리", "skill":"중국어", "imageName":"image2.png"]
        let dic3 = ["name":"태연", "skill":"보컬", "imageName":"image3.png"]
        let dic4 = ["name":"윤아", "skill":"연기", "imageName":"image4.png"]
        let dic5 = ["name":"티파니", "skill":"영어", "imageName":"image5.png"]
        let dic6 = ["name":"수영", "skill":"일본어", "imageName":"image6.png"]
        //배열로 묶기
        ar = [dic1, dic2, dic3, dic4, dic5, dic6]
        self.title = "소녀시대"
    }

   
    //섹션의 개수를 설정하는 메소드
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    
    //섹션 별 행의 개수를 설정하는 메소드
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return ar.count
    }

    
    //셀의 모양을 설정하는 메소드
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //셀의 identifier를 생성
        //스토리보드에 설정한 이름 그대로 쓰기
        let cellIdentifier = "CustomCell"
        //재사용 가능한 셀 만들기
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as? CustomCell
        //출력할 데이터 가져오기
        let dic = ar[indexPath.row]
        //셀에 설정
        cell!.lblName!.text = dic["name"]
        cell!.lblSkill!.text = dic["skill"]
        cell!.imgView!.image = UIImage(named: dic["imageName"]!)
        
        return cell!
    }
    

    //셀의 높이를 설정하는 메소드
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
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
