//
//  ListViewController.swift
//  TableViewUpdate
//
//  Created by 202 on 2021/03/02.
//

import UIKit

class ListViewController: UITableViewController {
    
    //데이터 배열을 프로퍼티로 선언
    var data = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "보유기술"
        
        data.append("C & C++")
        data.append("C#")
        data.append("Java")
        data.append("Kotlin")
        data.append("Swift")
        
        //바 버튼을 생성해서 오른쪽에 배치
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(insertItem(_:)))
        
        //네비게이션 바의 왼쪽에 edit 버튼을 배치
        self.navigationItem.leftBarButtonItem = self.editButtonItem
    }
    
    //바 버튼이 호출할 메소드
    @objc func insertItem(_ sender:UIBarButtonItem){
        //입력받기 위한 대화상자
        let alert = UIAlertController(title: "보유기술 등록", message: "등록할 보유기술을 입력하세요.", preferredStyle: .alert)
        //텍스트 필드 추가
        alert.addTextField(configurationHandler: {(tf) -> Void in
            tf.placeholder = "보유 기술"
        })
        //버튼 추가
        alert.addAction(UIAlertAction(title: "취소", style: .cancel))
        alert.addAction(UIAlertAction(title: "확인", style: .default, handler: {(action) -> Void in
            //입력한 내용 가져오기
            let item = alert.textFields?[0].text
            //입력한 내용이 없으면 리턴
            if item == nil || item?.trimmingCharacters(in: .whitespaces).count == 0{
                return
            }
            //데이터 삽입
            self.data.append(item!)
            
            //테이블 뷰 재출력
            //self.tableView.reloadData()
            
            //삽입하는 애니메이션 수행
            self.tableView.beginUpdates()
            self.tableView.insertRows(at: [IndexPath(row:self.data.count - 1, section: 0)], with: .right)
            self.tableView.endUpdates()
        }))
        //대화상자 출력
        self.present(alert, animated: true)
    }

    // MARK: - Table view data source

    //섹션의 개수
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    //섹션 별 행의 개수
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }

    //셀의 모양을 설정하는 메소드
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "Cell"
        var cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier)
        if cell == nil{
            cell = UITableViewCell(style: .default, reuseIdentifier: cellIdentifier)
        }
        cell?.textLabel?.text = data[indexPath.row]
        
        return cell!
    }
    
    //edit 버튼을 눌렀을 때 호출되는 메소드로 아이콘을 설정하는 메소드
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        //.delete
        return .none
    }
    
    //편집할 때 들여쓰기 설정 관련 메소드
    //false를 리턴해서 편집할 때 들여쓰기를 하지 않도록 한다.
    override func tableView(_ tableView: UITableView,
                            shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
    //실제 셀을 이동할 때 호출되는 메소드
    //sourceIndexPath - 선택한 자리
    //destinationIndexPath - 드랍을 한 자리
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        //데이터 이동
        let movedObject = data[sourceIndexPath.row]
        data.remove(at: sourceIndexPath.row)
        data.insert(movedObject, at: destinationIndexPath.row)
    }

    
    //edit 버튼을 누르고 아이콘을 눌렀을 때 호출되는 메소드 - 여기서 실제 편집 작업을 하면 된다.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        //데이터를 삭제하고 테이블 뷰를 재출력
        data.remove(at:indexPath.row)
        //tableView.reloadData()
        
        //삭제하는 애니메이션 수행
        self.tableView.beginUpdates()
        self.tableView.deleteRows(at: [IndexPath(row: indexPath.row, section: 0)], with: .fade)
        self.tableView.endUpdates()
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
