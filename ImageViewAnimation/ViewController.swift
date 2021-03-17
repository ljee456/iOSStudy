//
//  ViewController.swift
//  ImageViewAnimation
//
//  Created by 202 on 2021/02/24.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var lblPage: UILabel!
    
    //UIImage 배열 생성
    var imgArray = [UIImage]()
    //이미지 인덱스를 저장할 변수 생성
    var i:Int?
    //애니메이션 속도 변수 생성
    var speed:Float?
    
    
    //뷰 컨트롤러가 생성되고 뷰를 메모리 할당 한 호출되는 메소드
    //출력은 아직 안됨
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //이미지 파일의 이름이 규칙적이면 반복문 사용 가능
        //이미지 파일을 이용해서 UIImage를 만들어서 imgArray에 추가
        for idx in 0...4{
            imgArray.append(UIImage(named: "red\(idx).png")!)
        }
        
        //이미지 뷰의 애니메이션 이미지 설정
        imgView.animationImages = imgArray
        //현재 출력 중인 이미지 인덱스 설정
        i = 0
        imgView.image = imgArray[0]
        lblPage.text = "\(i!+1)/\(imgArray.count)"
        speed = 0.5
    }
    
    //changedSpeed 변수 연결 - valueChanged 이벤트로 메소드를 연결
    @IBAction func changedSpeed(_ sender: Any) {
        speed = slider.value
        
        if imgView.isAnimating {
            imgView.stopAnimating()
            //애니메이션 속도 설정
            speed = speed! * 3.0
            imgView.animationDuration = TimeInterval(Int(speed!) * imgArray.count)
            
            imgView.startAnimating()
        }
    }
    
    //prev 변수 연결 - touchUpInside 이벤트로 메소드를 연결
    @IBAction func prev(_ sender: Any) {
        //첫번째번호에서 이전버튼을 눌렀을 때 마지막번호를 보여주기 위한 작업
        i = i! - 1
        if i! < 0{
            i = imgArray.count - 1
        }
        imgView.image = imgArray[i!]
        lblPage.text = "\(i!+1)/\(imgArray.count)"
    }
    
    //play 변수 연결 - touchUpInside 이벤트로 메소드를 연결
    @IBAction func play(_ sender: Any) {
        //시작과 중지를 반복하기 위해 토글형태로 만들기
        if imgView.isAnimating == false{
            //애니메이션 속도 설정
            speed = speed! * 3.0
            imgView.animationDuration = TimeInterval(Int(speed!) * imgArray.count)
            
            imgView.startAnimating()
            (sender as! UIButton).setTitle("중지", for: .normal)
        }else{
            imgView.stopAnimating()
            (sender as! UIButton).setTitle("시작", for: .normal)
        }
    }
    
    //next 변수 연결 - touchUpInside 이벤트로 메소드를 연결
    @IBAction func next(_ sender: Any) {
        //마지막번호에서 다음버튼을 눌렀을 때 첫번째번호를 보여주기 위한 작업
        i = i! + 1
        if i! >= imgArray.count{
            i = 0
        }
        imgView.image = imgArray[i!]
        lblPage.text = "\(i!+1)/\(imgArray.count)"
    }
    

}

