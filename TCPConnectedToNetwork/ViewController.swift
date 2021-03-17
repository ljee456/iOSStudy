//
//  ViewController.swift
//  TCPConnectedToNetwork
//
//  Created by 202 on 2021/03/04.
//

import UIKit

class ViewController: UIViewController {
    //IP 주소와 port 번호 설정
    let ip = "192.168.10.47"
    let port = 9999
    
    //통신을 위한 TCPClient 프로퍼티
    var client : TCPClient?

    @IBOutlet weak var tfMsg: UITextField!
    @IBOutlet weak var tvMsg: UITextView!

    @IBAction func send(_ sender: Any) {
        //접속 객체가 제대로 만들어졌는지 확인
        //guard는 조건에 맞지 않으면 작업을 그만 수행하겠다는 의미
        guard let client = client else{
            return
        }
        //클라이언트가 nil이 아니면 서버에 연결
        switch client.connect(timeout: 60){
        //성공하면 메세지를 보내고
        case .success:
            appendToTextView(string: "연결 성공")
            if let response = sendRequest(string: "\(tfMsg.text)\n\n", using : client){
                appendToTextView(string: "Response:\(response)")
            }
        //실패하면 메세지를 출력만 하기
        case .failure(let error):
            appendToTextView(string: String(describing:error))
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //네트워크 접속 가능 여부를 result에 저장
        let reachability = Reachability()
        let result = reachability.isConnectedToNetwork()
        
        if result{
            //네트워크가 가능할 때 수행할 내용
            NSLog("네트워크 사용 가능")
            
            //TCP Client 생성
            client = TCPClient(address: ip, port: Int32(port))
        }else{
            //네트워크 사용이 불가능할 때 수행할 내용
            NSLog("네트워크 사용 불가능")
        }
    }

    
    //텍스트 뷰에 출력을 해주는 메소드
    private func appendToTextView(string:String){
        NSLog(string)
        tvMsg.text = tvMsg.text.appending("\n\(string)")
    }
    
    
    //데이터를 읽어오는 메소드
    private func readResponse(from client : TCPClient) -> String?{
        //잠시 대기
        sleep(3)
        
        guard let response = client.read(1024*10)
        else{
            return nil
        }
        return String(bytes: response, encoding: .utf8)
    }
    
    
    
    //데이터를 전송하는 메소드
    private func sendRequest(string:String, using client:TCPClient) -> String?{
        //텍스트 뷰에 메세지를 추가하는 메소드 호출
        appendToTextView(string:"Sending Message...")
        switch client.send(string: string){
        case .success:
            return readResponse(from : client)
        case .failure(let error):
            appendToTextView(string:String(describing:error))
            return nil
        }
    }

}

