//
//  ViewController.swift
//  ControlTest
//
//  Created by 202 on 2021/02/23.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtAge: UITextField!
    @IBOutlet weak var lblDisp: UILabel!
    
    @IBOutlet weak var button: UIButton!
    
    //키보드가 보여질 때 메소드
    @objc func keyboardShow(notification:Notification){
        //NSLog("키보드가 보여집니다.")
        
        //키보드가 올라올 때 버튼을 위로 올리기
        //버튼의 위치와 크기를 가져오기
        let frame = button.frame
        //y 좌표만 50을 빼기
        let moveFrame = CGRect(
            x: frame.origin.x,
            y: frame.origin.y - 50,
            width: frame.width,
            height: frame.height)
        //버튼에 적용
        button.frame = moveFrame
    }
    
    //키보드가 사라질 때 메소드
    @objc func keyboardHide(notification:Notification){
        //키보드가 올라올 때 버튼을 위로 올리기
        //버튼의 위치와 크기를 가져오기
        let frame = button.frame
        //y 좌표만 50을 빼기
        let moveFrame = CGRect(
            x: frame.origin.x,
            y: frame.origin.y + 50,
            width: frame.width,
            height: frame.height)
        //버튼에 적용
        button.frame = moveFrame
    }
    
    
    
    @IBAction func click(_ sender: Any) {
        //로그 출력
        //NSLog("버튼을 클릭")
        
        let name = txtName.text
        let age = txtAge.text
        
        lblDisp.text = "\(name!):\(age!)"
        
        //비우고 싶을 때
        txtName.text = ""
        txtAge.text = ""
    }
    
    //터치 관련 메소드
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        txtName.resignFirstResponder()
        txtAge.resignFirstResponder()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //노티피케이션과 메소드 연결
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardShow(notification:)),
            name: UIResponder.keyboardWillShowNotification,
            object: nil)
        
        //노티피케이션과 메소드 연결
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardHide(notification:)),
            name: UIResponder.keyboardWillHideNotification,
            object: nil)
        
        //처음부터 키보드가 보이도록 하기
        txtName.becomeFirstResponder()
        
        //텍스트 필드의 delegate 설정
        txtName.delegate = self
        
        //이미지 파일을 UIImage 객체로 변환
        let image1:UIImage! = UIImage(named: "btn_01.png")
        let image2:UIImage! = UIImage(named: "btn_02.png")
        //버튼에 이미지 설정
        button.setBackgroundImage(image1, for: .normal)
        button.setBackgroundImage(image2, for: .highlighted)
        //버튼의 타이틀 설정
        button.setTitle("보통", for: .normal)
        button.setTitle("누름", for: .highlighted)
    }

    //첫번째 텍스트 필드에서 return키를 눌렀을 때 호출되는 메소드
    @IBAction func hiddenKeyboard(_sender: Any) {
        txtName.resignFirstResponder()
    }
}

//클래스 확장 생성
extension ViewController : UITextFieldDelegate{
    //return 키를 눌렀을 때 호출되는 메소드 생성
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
}
