//
//  ListVC.swift
//  PhoneBookSQLite
//
//  Created by 202 on 2021/03/16.
//

import UIKit

class ListVC: UITableViewController {
    
    // 데이터 소스용 멤버 변수
    var phoneBook: [(num: Int, name: String, phone:String, addr: String)]!
    
    // SQLite 처리를 담당할 DAO 객체
    let dao = PhoneBookDAO()
    
    // UI 초기화 함수
    func initUI() {
            // 1. 내비게이션 타이틀용 레이블 속성 설정
            let navTitle = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 60))
            navTitle.numberOfLines = 2
            navTitle.textAlignment = .center
            navTitle.font = UIFont.systemFont(ofSize: 14)
            navTitle.text = "연락처 목록 \n" + " 총 \(self.phoneBook.count) 개"
            
            // 2. 내비게이션 바 UI 설정
            self.navigationItem.titleView = navTitle
            self.navigationItem.leftBarButtonItem = self.editButtonItem // 편집 버튼 추가
            
            // 3. 셀을 스와이프했을 때 편집 모드가 되도록 설정
            self.tableView.allowsSelectionDuringEditing = true
    }
    
    @IBAction func add(_ sender: Any) {
        //대화상자 생성
        let alert = UIAlertController(title: "신규 연락처 등록",
                                      message: "연락처를 등록해 주세요",
                                      preferredStyle: .alert)
        //대화 상자의 텍스트 필드 추가
        alert.addTextField() { (tf) in tf.placeholder = "이름" }
        alert.addTextField() { (tf) in tf.placeholder = "전화번호" }
        alert.addTextField() { (tf) in tf.placeholder = "주소" }
        
        //대화 상자의 버튼을 추가 - 확인을 누르면 입력받은 내용을 가지고 DAO의 createfunction을 불러낸다.
        alert.addAction(UIAlertAction(title: "취소", style: .cancel)) // 취소 버튼
        alert.addAction(UIAlertAction(title: "확인", style: .default) { (_) in // 확인 버튼
            
            let name = alert.textFields?[0].text
            let phone = alert.textFields?[1].text
            let addr = alert.textFields?[2].text
            if self.dao.create(name: name, phone: phone, addr: addr) {
                
                // 신규 데이터가 등록되면 DB에서 목록을 다시 읽어온 후, 테이블을 갱신해 준다.
                self.phoneBook = self.dao.find()
                self.tableView.reloadData()
                
                // 내비게이션 타이틀에도 변경된 데이터 정보를 반영한다.
                let navTitle = self.navigationItem.titleView as! UILabel
                navTitle.text = "연락처 목록 \n" + " 총 \(self.phoneBook.count) 개"
            }
        })
        self.present(alert, animated: false)
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        //데이터를 가져오기
        phoneBook = self.dao.find()
        //가져온 데이터를 가지고 네비게이션 바를 설정하는 것
        initUI()

    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
            // #warning Incomplete implementation, return the number of sections
            return 1
    }
        
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return self.phoneBook.count
    }
        
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            // indexPath 매개변수가 가리키는 행에 대한 데이터를 읽어온다.
            let rowData = self.phoneBook[indexPath.row]
            
            let cellIdentifier = "PHONE_CELL"
            var cell = tableView.dequeueReusableCell(withIdentifier: "PHONE_CELL")
            if cell == nil{
                cell = UITableViewCell(style: .subtitle, reuseIdentifier: cellIdentifier)
            }
            
            cell?.textLabel?.text = rowData.name
            cell?.detailTextLabel?.text = "\(rowData.phone) \(rowData.addr)"
            return cell!
    }
    
    //edit 버튼을 눌렀을 때 보여질 아이콘의 모양을 설정하는 메소드
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
           return .delete
   }
       
    //edit 버튼을 누르고 출력된 아이콘을 눌렀을 때 호출되는 메소드
    //삭제의 경우는 행 번호에 해당하는 데이터를 삭제
   override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
           // 1. 삭제할 행의 num를 구한다.
           let num = self.phoneBook[indexPath.row].num
           
           // 2. DB에서, 데이터 소스에서, 그리고 테이블 뷰에서 차례대로 삭제한다.
            //기본키를 가지고 와서 삭제
           if dao.remove(num:num) {
               self.phoneBook.remove(at: indexPath.row)
                //삭제하는 애니메이션
               tableView.deleteRows(at: [indexPath], with: .fade)
           }
   }

}
