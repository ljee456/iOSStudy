//
//  ViewController.swift
//  ControlClockTest
//
//  Created by 202 on 2021/02/23.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /*
        //타이머 생성 - 1초마다
        let timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerProc), userInfo: nil, repeats: true)
         */
        
        //클로저를 이용해서 타이머 생성
        let timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: {
            (timer:Timer) -> Void in
            //현재 시간을 문자열로 만들어서 label에 출력
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd ccc hh:mm:ss"
            //출력할 문자열
            let msg = formatter.string(from: Date())
            //레이블에 출력 , 클래스의 프로퍼티를 사용할 때는 self.을 추가
            self.label.text = msg
        })
        
        
        //레이블의 속성을 수정
        label.textColor = UIColor.green
        //경계선 두께와 색상 설정
        label.layer.borderWidth = 3.0
        label.layer.borderColor = UIColor.darkGray.cgColor
        
    }

    //타이머가 수행할 함수
    @objc func timerProc(timer:Timer){
        //현재 시간을 문자열로 만들어서 label에 출력
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd ccc hh:mm:ss"
        //출력할 문자열
        let msg = formatter.string(from: Date())
        //레이블에 출력
        label.text = msg
        
    }

}

