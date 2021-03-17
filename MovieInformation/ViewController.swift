//
//  ViewController.swift
//  MovieInformation
//
//  Created by 202 on 2021/03/05.
//

import UIKit

import Alamofire

class ViewController: UIViewController {
    
    //텍스트와 이미지를 출력할 View 프로퍼티
    //!는 한번 이렇게 만들면 바로 써도 된다
    var imageView:UIImageView!
    var imageName:UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //화면 전체 크기를 사용하기 위해서 화면 전체 정보를 가져오기
        let frame = UIScreen.main.bounds
        
        //이미지 뷰를 만들고 이미지 뷰를 배치
        imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 300, height: 300))
        //이렇게 하면 무조건 정 가운데 배치된다.
        imageView.center = CGPoint(x: frame.width/2, y: frame.height/2)
        self.view.addSubview(imageView)
        
        //레이블을 만들고 레이블을 배치
        imageName = UILabel(frame: CGRect(x: 0, y: 0, width: 300, height: 50))
        imageName.center = CGPoint(x: imageView.center.x, y: imageView.center.y + 200)
        imageName.text = "수지"
        self.view.addSubview(imageName)
        
        //동기식으로 이미지를 다운로드 받아서 출력하기
        let addr = "http://img.hani.co.kr/imgdb/resize/2018/0518/00502318_20180518.JPG"
        let imageUrl = URL(string: addr)
        /*
        let imageData = try! Data(contentsOf: imageUrl!)
        let image = UIImage(data: imageData)
        imageView.image = image
         */
        
        /*
        //스레드를 이용해서 다운로드 받도록 수정
        let imageDownThread = ImageDownThread()
        imageDownThread.url = imageUrl
        imageDownThread.imageView = imageView
        //스레드 시작
        imageDownThread.start()
         */
        
        //URLSession 과 URLSessionTask를 이용한 이미지 다운로드
        //세션 생성
        let session = URLSession.shared
        //작업 생성
        let task = session.dataTask(with: imageUrl!, completionHandler: {(data:Data?, response:URLResponse?, error:Error?) -> Void in
            //에러가 발생하면
            if error != nil{
                //에러가 발생했을 때 수행할 내용
                //공부를 할 때는 NSLog로 하지만 실제 유저에게는 대화상자로 보여준다.
                NSLog("다운로드에러:\(error!.localizedDescription)")
                return
            }
            //정상적으로 동작할 때 수행할 내용
            //이미지 뷰에 받은 이미지를 출력
            OperationQueue.main.addOperation {
                self.imageView.image = UIImage(data: data!)
            }
        })
        //작업을 실행
        task.resume()
        
        
        
        /*
        //데이터를 비동기적으로 다운로드 받기
        let request = AF.request("https://httpbin.org/get", method:.get, parameters:nil)
        request.response{
            response in
            let msg = String(data: response.data!, encoding: .utf8)
            NSLog(msg!)
        }
        */
        
        
        /*
        //데이터를 비동기적으로 다운로드 받기 - 문자열로 받아오기
        let request = AF.request("https://www.daum.net", method:.get, parameters:nil)
        request.responseString(
            completionHandler:{
                response in NSLog(response.value!)
                
            })
         */
        
        
        /*
        //카카오 Open API 가져오기
        //URL 생성
        let kakaoAddr = "https://dapi.kakao.com/v3/search/book?target=title&query="
        let queryString = "자바".addingPercentEncoding(withAllowedCharacters:.urlUserAllowed)
        let kakaoUrl = "\(kakaoAddr)\(queryString!)"
        
        let request = AF.request(kakaoUrl, method:.get, encoding: JSONEncoding.default, headers:["Authorization":"KakaoAK 06fab290c9f4eb6f130c09796d57bc30"])
        request.responseJSON{
            response in
            let jsonObject = response.value as? [String:Any]
            NSLog("\(jsonObject!)")
            let documents = jsonObject["documents"] as! NSArray
            for index in 0 ... (documents.count - 1){
                let item = documents[index] as! NSDictionary
                NSLog("\(item["authors"]!)")
            }
        }
         */
        
        
        /*
        //파일업로드
        //업로드할 이미지 데이터를 생성
        let image1 = UIImage(named:"img.jpg")
        let imageData = image1!.jpegData(compressionQuality:0.50)
        
        AF.upload(multipartFormData:
                    {multipartFormData in
                        multipartFormData.append(Data("네이버".utf8), withName:"itemname")
                        multipartFormData.append(Data("10000".utf8), withName:"price")
                        multipartFormData.append(Data("aabbcc".utf8), withName:"description")
                        multipartFormData.append(Data("2021-03-05".utf8), withName:"updatedate")
                        multipartFormData.append(imageData!, withName:"pictureurl", fileName:"google.jpg", mimeType:"image/jpg")
                    }, to:"http://cyberadam.cafe24.com/item/insert").responseJSON{
                        response in
                        if let jsonObject = response.value as? [String:Any]{
                            let result = jsonObject["result"] as! Int
                            NSLog("\(result)")
                        }
                    }
        */
    }
}

//이미지를 다운로드 받아 출력하는 스레드
class ImageDownThread : Thread{
    var imageView : UIImageView!
    var url : URL!
    override func main() {
        let imageData = try! Data(contentsOf: url)
        let image = UIImage(data: imageData)
        //imageView.image = image
        
        //Main Thread에서 이미지를 출력하도록 수정
        OperationQueue.main.addOperation {
            self.imageView.image = image
        }
    }
}
