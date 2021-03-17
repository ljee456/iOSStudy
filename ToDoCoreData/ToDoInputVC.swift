//
//  ToDoInputVC.swift
//  ToDoCoreData
//
//  Created by 202 on 2021/03/17.
//

import UIKit

class ToDoInputVC: UIViewController {

    @IBOutlet weak var titleView: UITextField!

    @IBOutlet weak var contentsView: UITextField!

    @IBOutlet weak var runtimeView: UIDatePicker!

    @IBAction func cancel(_ sender: Any) {
        //자신을 출력한 뷰 컨트롤러를 이용해서 현재 뷰 컨트롤러를 제거
        self.presentingViewController?.dismiss(animated: true)
    }

    @IBAction func save(_ sender: Any) {
        //자신을 출력한 뷰 컨트롤러를 찾아오기
        let navVC = self.presentingViewController as! UINavigationController
        
        let toDoListViewController = navVC.topViewController as! ToDoListVC
        
        let title = titleView.text
        let contents = contentsView.text
        let runtime = runtimeView.date
        //입력받은 내용을 save 메소드에게 전달해서 저장
        let result = toDoListViewController.save(title: title!, contents: contents!, runtime: runtime)
        
        toDoListViewController.dismiss(animated: true){()->(Void)in
            if result == true {toDoListViewController.tableView.reloadData()}
            else {
                let alert = UIAlertController(title: "삽입실패", message: "데이터를 확인해보세요", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "확인", style: .default))
                self.present(alert, animated: true)
            }
        }
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()

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
