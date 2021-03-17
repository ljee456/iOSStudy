//
//  ViewController.swift
//  BasicTable
//
//  Created by 202 on 2021/02/26.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    //테이블 뷰에 출력할 문자열 배열 프로퍼티 선언
    //!을 붙이면 nil을 저장할 수 있고 사용할 때 자동으로 optional을 제거해준다.
    var data : [String]!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //테이블 뷰 출력과 이벤트 처리를 위한 메소드를 소유한 인스턴스를 설정
        tableView.dataSource = self
        tableView.delegate = self
        
        data = Array<String>()
        data.append("한국")
        data.append("미국")
        data.append("중국")
        data.append("영국")
        data.append("인도")
        data.append("일본")
        data.append("독일")
    }


}


extension ViewController:UITableViewDelegate, UITableViewDataSource{
    //섹션의 개수를 설정하는 메소드 - 구현하지 않으면 1을 리턴한 것으로 간주
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    //섹션 별로 행의 개수를 설정하는 메소드 - 필수
    //section은 섹션의 인덱스
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    //위치 별로 셀을 만들어주는 메소드
    //indexPath가 셀의 인덱스이다.
    //section과 row 프로퍼티로 인덱스를 제공
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //셀의 식별자를 생성
        let cellIdentifier = "Cell"
        
        //식별자를 이용해서 재사용 가능한 셀을 생성
        var cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier)
        //재사용 가능한 셀이 없을 때
        if cell == nil{
            cell = UITableViewCell(style: .default, reuseIdentifier: cellIdentifier)
        }
        //셀을 설정
        cell?.textLabel?.text = data[indexPath.row]
        //셀을 생성하도록 리턴
        return cell!
    }
    
    
    //셀의 높이를 설정하는 메소드
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    //셀의 들여쓰기를 설정하는 메소드
    func tableView(_ tableView: UITableView, indentationLevelForRowAt indexPath: IndexPath) -> Int {
        return 10
    }
    
    //셀을 선택했을 때 호출되는 메소드
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //행 번호에 해당하는 데이터 찾아오기
        let con = data[indexPath.row]
        
        let alert = UIAlertController(title: "국가", message: con, preferredStyle: .alert)
        
        let ok = UIAlertAction(title: "확인", style: .default)
        
        alert.addAction(ok)
        self.present(alert, animated: true)
    }
}
