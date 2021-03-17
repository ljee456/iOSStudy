//
//  SecondViewController.swift
//  ViewSwitching
//
//  Created by 202 on 2021/02/25.
//

import UIKit

class SecondViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    //자신을 출력한 뷰 컨트롤러로 돌아가기
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //자신을 출력한 뷰 컨트롤러를 가져오기
        let parent = self.presentingViewController as! ViewController
        parent.dismiss(animated: true)
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
