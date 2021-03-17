//
//  MyNavigationBar.swift
//  ToDoCoreData
//
//  Created by 202 on 2021/03/17.
//

import UIKit

class MyNavigationBar: UINavigationBar {
    //높이를 저장할 프로퍼티
    var customHeight : CGFloat = 200
    
    //화면에 보여질 때 크기를 설정하는 메소드 재정의
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: customHeight)
    }
    
    //하위 뷰를 그려주는 메소드를 재정의
    override func layoutSubviews() {
        super.layoutSubviews()
        
        //크기 설정
        let y = UIApplication.shared.statusBarFrame.height
        self.frame =  CGRect(x: self.frame.origin.x, y: self.frame.origin.y, width: self.frame.width, height: customHeight)
        
        for subview in self.subviews{
            var stringFromClass = NSStringFromClass(subview.classForCoder)
            if stringFromClass.contains("Background"){
                subview.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: customHeight)
                subview.backgroundColor = self.backgroundColor
            }
            stringFromClass = NSStringFromClass(subview.classForCoder)
            if stringFromClass.contains("BarContent"){
                subview.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: customHeight)
                subview.backgroundColor = self.backgroundColor
            }
        }
    }
}
