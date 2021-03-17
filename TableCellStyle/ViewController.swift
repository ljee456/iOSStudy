//
//  ViewController.swift
//  TableCellStyle
//
//  Created by 202 on 2021/03/02.
//

import UIKit

class ViewController: UIViewController {

    //출력할 데이터 배열
    var ar = [String]()
    var imageNames = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //데이터 배열 만들기
        ar.append("제시카")
        ar.append("유리")
        ar.append("태연")
        ar.append("윤아")
        ar.append("티파니")
        ar.append("수영")
        
        imageNames.append("image1.png")
        imageNames.append("image2.png")
        imageNames.append("image3.png")
        imageNames.append("image4.png")
        imageNames.append("image5.png")
        imageNames.append("image6.png")
        
    }


}

//TableView와 관련된 extension
extension ViewController:UITableViewDelegate, UITableViewDataSource{
    //섹션(그룹)의 개수를 설정하는 메소드 - 필수는 아님(만들지 않으면 1을 리턴함)
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    //섹션 별 행의 개수를 설정하는 메소드 - 필수
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ar.count
    }
    
    //셀을 만들어주는 메소드 - 필수
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "Cell"
        var cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier)
        
        if cell == nil {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: cellIdentifier)
        }
        //텍스트를 출력
        cell!.textLabel!.text = ar[indexPath.row]
        //이미지를 출력
        cell!.imageView!.image = UIImage(named: "imageNames[indexPath.row]")
        //보조 텍스트를 출력 - style이 default이면 사용할 수 없음(subtitle이여야함)
        cell!.detailTextLabel?.text = "소녀시대"
        
        return cell!
    }
}
