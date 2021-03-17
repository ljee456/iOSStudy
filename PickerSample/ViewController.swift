//
//  ViewController.swift
//  PickerSample
//
//  Created by 202 on 2021/02/25.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var pickerImage: UIPickerView!
    @IBOutlet weak var lblImageName: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    //UIImage 배열 프로퍼티
    //권장
    //이 경우는 인스턴스 생성까지 수행
    var imageArray:[UIImage?]? = nil
    //실제 데이터까지 초기화
    var imageFileName:[String]? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //viewDidLoad 메소드에서 프로퍼티 초기화
        imageArray = [UIImage?]()
        imageFileName = ["red0.png","red1.png","red2.png","red3.png","red4.png"]
        
        //이미지 파일이름을 이용해서 UIImage를 생성하고 배열에 추가
        for i in 0..<imageFileName!.count{
            let image = UIImage(named: imageFileName![i])
            imageArray?.append(image)
        }
        //레이블에 첫번째 이미지 이름을 출력
        lblImageName.text = imageFileName![0]
        //첫번째 이미지를 이미지 뷰에 출력
        imageView.image = imageArray![0]
        
        //PickerView의 출력과 이벤트 처리에 관련된 메소드의 위치를 설정
        //PickerView 와 프로토콜 구현한 메소드를 연결
        pickerImage.delegate = self
        pickerImage.dataSource = self
        
    }
    
    //터치했을 때
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //0 ~ 20000 사이에 랜덤한 정수 추출
        let random1 = arc4random_uniform(20000)
        let random2 = arc4random_uniform(20000)
        let random3 = arc4random_uniform(20000)
        
        //터치했을 때 피커뷰의 선택을 변경
        pickerImage.selectRow(20000 + Int(random1), inComponent: 0, animated: true)
        pickerImage.selectRow(20000 + Int(random2), inComponent: 1, animated: true)
        pickerImage.selectRow(20000 + Int(random3), inComponent: 2, animated: true)
        
        //선택된 데이터 확인
        NSLog("1번열:\(20000 + Int(random1))")
        NSLog("2번열:\(20000 + Int(random2))")
        NSLog("3번열:\(20000 + Int(random3))")
    }
}

//PickerView 출력과 이벤트 처리를 위한 extension
extension ViewController: UIPickerViewDataSource, UIPickerViewDelegate{
    //열의 개수를 설정하는 메소드
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        //열이 3개로 보여짐
        return 3
    }
    //각 열별로 행의 개수를 설정하는 메소드
    //component가 열 번호이다.
    func pickerView(_ pickerView: UIPickerView,
                    numberOfRowsInComponent component: Int) -> Int {
        //원래는 5개의 이미지가 있지만 5만개의 이미지로 리턴
        return imageFileName!.count * 10000
    }
    
    /*
    //문자열을 리턴하는 메소드
    //component가 열 번호이고 row가 행 번호
    func pickerView(_ pickerView: UIPickerView,
                    titleForRow row: Int,
                    forComponent component: Int) -> String? {
        return imageFileName![row]
    }
     */
    //행의 높이를 설정해주는 메소드
    func pickerView(_ pickerView: UIPickerView,
                    rowHeightForComponent component: Int) -> CGFloat {
        return 80
    }
    //PickerView에 뷰를 출력하는 메소드
    func pickerView(_ pickerView: UIPickerView,
                    viewForRow row: Int,
                    forComponent component: Int,
                    reusing view: UIView?) -> UIView {
        let imageView = UIImageView(image: imageArray![row % imageFileName!.count])
        imageView.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
        return imageView
    }
    
    //pickerview의 선택이 변경될 때 호출되는 메소드
    func pickerView(_ pickerView: UIPickerView,
                didSelectRow row: Int,
                inComponent component: Int){
        //선택한 행번호의 데이터를 출력
        lblImageName.text = imageFileName![row % imageFileName!.count]
        imageView.image = imageArray![row % imageFileName!.count]
    }
}
