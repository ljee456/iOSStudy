//
//  SecondViewController.swift
//  ViewControllerSwitching
//
//  Created by 202 on 2021/02/26.
//

import UIKit

class SecondViewController: UIViewController {
    @IBOutlet weak var lblSecond: UILabel!
    
    //데이터를 넘겨받을 프로퍼티
    //연습이라서 문자열로 하지만 숫자 등 다 가능
    var msg : String?
    
    @IBAction func moveFirst(_ sender: Any) {
        //하위 뷰 컨트롤러에서 상위 뷰 컨트롤러로 이동하는 것은 상위 뷰 컨트롤러를 만드는 것이 아니고
        //현재 뷰 컨트롤러를 화면에서 제거해서 상위 뷰 컨트롤러를 다시 보이게 하는 것이다.
        
        //상위 뷰 컨트롤러를 찾아온다
        let firstVC = self.presentingViewController as! ViewController
        //데이터 넘겨주기
        firstVC.subData = "상위 뷰 컨트롤러에게 넘겨준 데이터"
        //현재 출력 중인 뷰 컨트롤러를 제거
        firstVC.dismiss(animated: true)
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //만일 msg가 nil이면 아무일을 하지 않고 리턴하고
        //그렇지 않으면 레이블에 출력
        //이렇게 하면 예외가 생기지 않는다.
        guard let t = msg else{
            return
        }
        lblSecond.text = t
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
