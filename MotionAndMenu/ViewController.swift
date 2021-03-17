//
//  ViewController.swift
//  MotionAndMenu
//
//  Created by 202 on 2021/02/23.
//

import UIKit

class ViewController: UIViewController {
    //ViewController가 FirstResponder가 될 수 있도록 프로퍼티 재정의
    override var canBecomeFirstResponder: Bool{
        get{
            return true
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //ViewController가 FirstResponder가 되도록 설정
        self.becomeFirstResponder()
        
        //길게 눌렀을 때 호출할 메소드 설정 - target은 Selector를 누가 가지고 있냐라는 뜻 , Selector은 함수
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress))
        //길게 눌렀을 때의 옵션 설정
        longPress.minimumPressDuration = 2.0 //2초
        //15픽셀정도 움직여도 동일한 범주내에 누른 것으로 간주함
        longPress.allowableMovement = 15
        //현재 뷰를 길게 누르면 longPress를 수행
        view.addGestureRecognizer(longPress)
    }
    
    //뷰를 길게 누르면 호출될 메소드
    @objc func handleLongPress(sender:UILongPressGestureRecognizer){
        //메뉴를 생성
        let menuItem = UIMenuItem(title: "Menu", action: #selector(menuEvent))
        //메뉴를 메뉴 컨트롤러에 추가
        UIMenuController.shared.menuItems = [menuItem]
        //출력할 좌표 설정
        let pt = sender.location(in: self.view)
        //메뉴 출력
        UIMenuController.shared.showMenu(from: self.view, rect: CGRect(x: pt.x, y: pt.y, width: 100, height: 100))
    }
    
    //메뉴에 연결하는 selector 함수
    //메뉴를 눌렀을 때 호출될 함수
    @objc func menuEvent(){
        NSLog("메뉴 Click")
    }
    
    
    //흔들기가 시작되면 호출될 메소드
    override func motionBegan(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        //메세지 출력 대화상자를 만들어서 출력
        let alert = UIAlertController(title: "흔들기", message: "상속받은 메소드 재정의", preferredStyle: .alert)
        //버튼 만들기
        let ok = UIAlertAction(title:"확인", style: .default)
        alert.addAction(ok)
        self.present(alert, animated: true)
    }

}

