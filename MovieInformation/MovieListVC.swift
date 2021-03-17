//
//  MovieListVC.swift
//  MovieInformation
//
//  Created by 202 on 2021/03/05.
//

import UIKit

import Alamofire
import Nuke

class MovieListVC: UITableViewController {

    //하단에서 위로 드래그해서 업데이트를 할 때 하단의 데이터까지 스크롤이 가능한지 확인을 위한 플래그 프로퍼티
    var flag = false
    
    //데이터 파싱을 위한 프로퍼티 선언
    //현재 출력중인 페이지 번호를 저장
    var page = 1
    //데이터 목록을 저장할 프로퍼티
    //lazy가 붙으면 처음 사용할 때 생성된다. - 이것을 지연생성이라함.
    //={}() 이렇게 표현하는 것은 클로저를 이용한 초기화 작업이다.
    lazy var list : [MovieVO] = {
        var datalist = [MovieVO]()
        return datalist
    }()
    
    //데이터를 다운로드 받아서 파싱하는 메소드
    func downloadData(){
        //다운로드 받을 URL : http://cyberadam.cafe24.com/movie/list?page=1
        //page는 1부터 시작한다.
        
        //다운로드 받을 URL을 생성
        let url = "http://cyberadam.cafe24.com/movie/list?page=\(page)"
        //GET방식으로 가져오고 결과는 JSON인 경우로 작업
        //인터넷이나 옛날 교재에는 AF가 아니고 Alamofire로 되어 있는 경우가 있다.
        //책이나 인터넷에 있는 코드대로 해보고자하면 Podfile에 작성할 때 Alamofire의 옛날 버전을 다운로드 받도록 설정해줘야 한다.
        let request = AF.request(url, method: .get, encoding: JSONEncoding.default, headers: [:])
        //응답을 받으면 호출
        request.responseJSON{
            response in
            //파싱된 결과는 response.value
            //결과를 디셔너리로 변환 - 데이터가 { 로 시작히기 때문
            if let jsonObject = response.value as? [String:Any]{
                //이름은 list이고 [ 이면 list 키의 내용을 배열로 변환
                let list = jsonObject["list"] as! NSArray
                //배열은 순회를 해준다.
                for index in 0...(list.count - 1){
                    //항목 하나를 Dictionary로 변환 [ 다음 { 안에 데이터가 있기때문
                    let item = list[index] as! NSDictionary
                    //항목 하나를 저장할 객체를 생성
                    var movie = MovieVO()
                    //각 속성의 값을 대입
                    movie.movieid = ((item["movieid"] as! NSNumber).intValue)
                    movie.title = item["title"] as? String
                    movie.genre = item["genre"] as? String
                    movie.thumbnail = item["thumbnail"] as? String
                    movie.link = item["link"] as? String
                    movie.rating = ((item["rating"] as! NSNumber).doubleValue)
                    //이미지 가져오기
                    let url:URL! = URL(string: "http://cyberadam.cafe24.com/movieimage/\(movie.thumbnail!)")
                    let imageData = try! Data(contentsOf: url)
                    movie.image = UIImage(data: imageData)
                    
                    //배열에 삽입하기
                    self.list.append(movie)
                }
                
                //현재 페이지 번호에 따른 refresh control 출력 여부를 설정
                let totalCount = (jsonObject["count"] as! NSNumber).intValue
                if(self.list.count >= totalCount){
                    self.refreshControl?.isHidden = true
                }
                //데이터 재출력
                self.tableView.reloadData()
            }
        }
    }
    
    //refresh control이 보여질 때 호출되는 메소드
    @objc func handleRequest(_ refreshControl:UIRefreshControl){
        //페이지 번호 증가
        self.page = self.page + 1
        //데이터를 다운로드 받는 메소드 호출
        self.downloadData()
        //refresh control을 숨기기
        refreshControl.endRefreshing()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "영화 목록"
        
        //데이터 가져오는 메소드를 호출
        downloadData()
        
        //refresh control과 이벤트 처리 메소드 연결
        self.refreshControl = UIRefreshControl()
        self.refreshControl?.addTarget(self, action: #selector(self.handleRequest(_:)), for: .valueChanged)
        self.refreshControl?.tintColor = UIColor.gray
    }

    // MARK: - Table view data source

    //섹션(그룹)의 개수를 설정하는 메소드
    override func numberOfSections(in tableView: UITableView) -> Int {

        return 1
    }

    //섹션 별 행의 개수를 설정하는 메소드
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return list.count
    }

    //셀의 모양을 설정하는 메소드
    //셀 모양을 설정하기 전에 Main.storyboard에 가서 셀의 Identifier의 이름을 확인해본 후 작업 - MovieCell
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //행 번호에 해당하는 데이터 찾아오기
        let row = self.list[indexPath.row]
        //셀을 생성
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell") as! MovieCell
        
        cell.lblTitle.text = row.title
        cell.lblGenre.text = row.genre
        cell.lblRating.text = "\(row.rating!)"
        //cell.imgThumbnail.image = row.image
        //Nuke 라이브러리를 이용해서 이미지 출력
        //메인 스레드에서 작업하도록 설정
        DispatchQueue.main.async(execute: {
            //이미지를 다운로드 받을 URL 생성
            let url : URL! = URL(string: "http://cyberadam.cafe24.com/movieimage/\(row.thumbnail!)")
            //옵션 설정
            let options = ImageLoadingOptions(placeholder:UIImage(named: "plcaeholder"), transition:.fadeIn(duration:2))
            Nuke.loadImage(with: url, options: options, into: cell.imgThumbnail)
        })
        
        return cell
    }
    
    //셀의 높이를 설정하는 메소드
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    //셀이 출력될 때 호출되는 메소드
    //가장 하단에서 스크롤하면 데이터를 불러와서 하단에 출력
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        //가장 마지막 셀이 보여지면 flag를 true로 함
        if(flag == false && indexPath.row == self.list.count - 1){
            flag = true
        }else if(flag == true && indexPath.row == self.list.count - 1){
            self.page = self.page + 1
            downloadData()
        }
    }

    
    //셀을 선택했을 때 호출되는 메소드
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //출력할 하위 뷰 컨트롤러 객체를 생성
        let movieDetailVC = self.storyboard?.instantiateViewController(identifier: "MovieDetailVC") as! MovieDetailVC
        //넘겨줄 데이터 생성
        movieDetailVC.link = list[indexPath.row].link
        //타이틀 설정
        movieDetailVC.title = list[indexPath.row].title
        //하위 뷰 컨트롤러 출력
        self.navigationController?.pushViewController(movieDetailVC, animated: true)
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
