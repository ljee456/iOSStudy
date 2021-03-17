//
//  ViewController.swift
//  ImageSwipe
//
//  Created by 202 on 2021/02/24.
//

import UIKit

class ViewController: UIViewController {
    //스크롤 뷰
    var scrollView:UIScrollView?
    //스크롤 뷰에 출력할 컨텐츠 뷰
    var contentView:UIView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //적절한 크기로 ScrollView 생성
        scrollView = UIScrollView(frame: CGRect(x: 10, y: 60, width: 400, height: 400))
        
        //내용이 되는 뷰를 생성
        contentView = UIView(frame: CGRect(x: 0, y: 0, width: 400*5, height: 400))
        
        //x좌표를 저장할 변수
        var total:Int = 0
        
        for i in 0...4{
            //이미지 뷰를 x 좌표 방향으로 400씩 옮기면서 생성됨
            let imageView = UIImageView(frame: CGRect(x: total, y: 0, width: 400, height: 400))
            
            let image = UIImage(named: "red\(i).png")
            imageView.image = image
            //400, 400, 400씩 옮겨가면서 생성됨.
            total = total + 400
            
            //contentView에 추가
            contentView?.addSubview(imageView)
            
        }
        //contentView를 스크롤 뷰에 추가
        scrollView?.addSubview(contentView!)
        scrollView!.contentSize = contentView!.frame.size
        
        //스크롤 뷰를 페이지 단위로만 스크롤 할 수 있도록 설정
        scrollView!.isPagingEnabled = true
        
        //스크롤 뷰를 현재 뷰위에 올려놓기(배치)
        self.view.addSubview(scrollView!)
    }


}

