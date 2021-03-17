//
//  ViewController.swift
//  TableViewClassification
//
//  Created by 202 on 2021/03/02.
//

import UIKit

class ViewController: UIViewController{

    @IBOutlet weak var tableView: UITableView!
    //이름을 가지고 있을 배열
    var data : Array<String> = []
    
    //섹션 별로 분류된 데이터를 저장할 배열
    var sectionData:Array<Dictionary<String, Any>> = []
    
    //인덱스를 저장할 배열
    var indexes:Array<String> = []
    
    //검색 컨트롤러
    let searchController = UISearchController(searchResultsController: nil)
    //검색된 결과를 저장할 배열
    var filteredPlayers = [String]()
    
    //문자열을 받아서 첫 글자의 자음을 리턴하는 메소드
    func subtract(data:String) -> String{
        //"나" 랑 비교
        var result = data.compare("나")
        //나보다 작다면
        if result == ComparisonResult.orderedAscending{
            return "ㄱ"
        }
        //"다" 랑 비교
        result = data.compare("다")
        //다 보다 작다면
        if result == ComparisonResult.orderedAscending{
            return "ㄴ"
        }
        //"라" 랑 비교
        result = data.compare("라")
        //라 보다 작다면
        if result == ComparisonResult.orderedAscending{
            return "ㄷ"
        }
        //"마" 랑 비교
        result = data.compare("마")
        //마 보다 작다면
        if result == ComparisonResult.orderedAscending{
            return "ㄹ"
        }
        //"바" 랑 비교
        result = data.compare("바")
        //바 보다 작다면
        if result == ComparisonResult.orderedAscending{
            return "ㅁ"
        }
        //"사" 랑 비교
        result = data.compare("사")
        //사 보다 작다면
        if result == ComparisonResult.orderedAscending{
            return "ㅂ"
        }
        //"아" 랑 비교
        result = data.compare("아")
        //아 보다 작다면
        if result == ComparisonResult.orderedAscending{
            return "ㅅ"
        }
        //"자" 랑 비교
        result = data.compare("자")
        //자 보다 작다면
        if result == ComparisonResult.orderedAscending{
            return "ㅇ"
        }
        //"차" 랑 비교
        result = data.compare("차")
        //차 보다 작다면
        if result == ComparisonResult.orderedAscending{
            return "ㅈ"
        }
        //"카" 랑 비교
        result = data.compare("카")
        //카 보다 작다면
        if result == ComparisonResult.orderedAscending{
            return "ㅊ"
        }
        //"타" 랑 비교
        result = data.compare("타")
        //타 보다 작다면
        if result == ComparisonResult.orderedAscending{
            return "ㅋ"
        }
        //"파" 랑 비교
        result = data.compare("파")
        //파 보다 작다면
        if result == ComparisonResult.orderedAscending{
            return "ㅌ"
        }
        //"하" 랑 비교
        result = data.compare("하")
        //하 보다 작다면
        if result == ComparisonResult.orderedAscending{
            return "ㅍ"
        }
        return "ㅎ"
        
    }
    
    //검색 입력란에 데이터가 없는지 확인하는 메소드
    func searchBarIsEmpty() -> Bool{
        //입력된 문자열이 비었는지 여부를 확인해서 비어 있으면 true를 리턴
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    //검색 입력란에 내용을 입력하면 호출되는 메소드
    func filterContentForSearchText(_ searchText:String, scope:String = "All"){
        //data 배열을 순회하면서 data 배열의 모든 텍스트를 소문자로 변경하고
        //변경된 문자열에 searchText를 소문자로 변경한 데이터가
        //포함되어 있는 것만 골라서 filteredPlayers 에 대입
        filteredPlayers = data.filter({(player:String) -> Bool in
            return player.lowercased().contains(searchText.lowercased())
        })
        //테이블 뷰 데이터 재출력
        tableView.reloadData()
    }
    
    //검색 입력 란의 상태를 리턴하는 메소드
    func isFIltering() -> Bool{
        return searchController.isActive && !searchBarIsEmpty()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //데이터 배열
        data = ["루니","토레스","호날두","메시","제라드","푸욜",
                "이니에스타","호나우지뉴","카카","람","반데사르",
                "에브라","램파드","존테리","에시앙","반페르시",
                "수아레즈","비디치","퍼디난드","즐라탄","체흐",
                "뮐러","마르코로이스","벤제마","드로그바","사비",
                "사비알론소","데이비드베컴","스콜스","가레스베일"
                ,"다비드비야","네이마르","클로제","그리즈만"]
        
        //인덱스 배열
        indexes = ["ㄱ","ㄴ","ㄷ","ㄹ","ㅁ","ㅂ","ㅅ","ㅇ","ㅈ","ㅊ","ㅋ","ㅌ","ㅍ","ㅎ"]
        
        //데이터 분류 작업
        //14개의 임시 배열 생성
        var temp:[[String]] = Array(repeating: Array(), count: 14)
        
        var i = 0
        while i < indexes.count{
            //인덱스에서 순서대로 글자를 가져옴
            let firstName = indexes[i]
            
            var j = 0
            //데이터 배열을 순회
            while j < data.count{
                //데이터를 하나씩 가져와서 첫글자의 자음을 찾음
                //동일한 인덱스를 만나면 인덱스 번째 배열에 삽입
                let str = data[j]
                if firstName == self.subtract(data: str){
                    temp[i].append(str)
                }
                j = j + 1
            }
            i = i + 1
        }
        
        //배열 데이터 정렬
        i = 0
        while i < temp.count{
            if temp[i].count > 2{
                temp[i].sort()
            }
            i = i + 1
        }
        
        //디셔너리를 만들어서 분류 배열에 삽입
        i = 0
        while i < indexes.count{
            //배열에 데이터가 존재하는 것만 sectionData에 삽입
            if temp[i].count > 0{
                var dic : Dictionary<String, Any> = [:]
                dic["section_name"] = indexes[i]
                dic["data"] = temp[i]
                sectionData.append(dic)
            }
            i = i + 1
        }
        
        //서치바 배치
        //서치바에서 검색을 눌렀을 때 호출될 메소드의 위치를 설정
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "검색어를 입력하세요"
        self.navigationItem.searchController = searchController
        self.definesPresentationContext = true
        
    }


}

extension ViewController:UISearchResultsUpdating{
    func updateSearchResults(for searchController: UISearchController) {
        //입력된 문자열을 가지고 데이터를 찾습니다.
        filterContentForSearchText(searchController.searchBar.text!)
    }
}

extension ViewController : UITableViewDelegate, UITableViewDataSource{
    //섹션의 개수를 설정하는 메소드
    func numberOfSections(in tableView: UITableView) -> Int {
        //검색바에 입력 중이면 섹션은 1개만 출력
        if isFIltering() {
            return 1
        }
        return sectionData.count
    }
    
    //섹션 별 헤더 설정
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        //검색바에 입력 중일 때 출력
        if isFIltering(){
            return "검색 결과"
        }
        let dic = sectionData[section]
        let sectionName = (dic["section_name"] as! NSString) as String
        return sectionName
    }
    
    //섹션 별 행의 개수를 설정하는 메소드
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //검색 바에 입력 중일 때
        if isFIltering(){
            return filteredPlayers.count
        }
        //섹션 번호에 해당하는 데이터를 찾아오고
        let dic = sectionData[section]
        //찾아온 데이터의 data 키의 값을 Array로 변환
        //swift 자료형으로 바로 변환이 안되면 NS로 변환 후 다시 변환하면 된다.
        let ar = (dic["data"] as! NSArray) as Array
        
        return ar.count
    }
    
    //셀을 만들어주는 메소드
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "Cell"
        
        var cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier)
        if cell == nil{
            cell = UITableViewCell(style: .default, reuseIdentifier: cellIdentifier)
        }
        
        if isFIltering(){
            cell!.textLabel!.text = (filteredPlayers[indexPath.row])
        }else{
            //데이터 찾아오기
            let dic = sectionData[indexPath.section]
            let ar = (dic["data"] as! NSArray) as Array
            cell!.textLabel!.text = (ar[indexPath.row] as! NSString) as String
        }
        
        return cell!
    }
    
    //테이블 뷰에 인덱스를 출력하는 메소드
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return indexes
    }
    
    //인덱스를 누르면 이동할 섹션 번호를 설정하는 메소드
    func tableView(_ tableView: UITableView, sectionForSectionIndexTitle title: String, at index: Int) -> Int {
        //누른 인덱스의 문자열과 섹션의 타이틀이 일치하면 그 위치로 이동
        for i in 0..<sectionData.count{
            let dic = sectionData[i]
            let sectionName = dic["section_name"] as! String
            if sectionName == title{
                return i
            }
        }
        return -1
    }
}
