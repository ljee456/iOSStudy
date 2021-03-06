//
//  PhoneBookDAO.swift
//  PhoneBookSQLite
//
//  Created by 202 on 2021/03/16.
//

import Foundation
import UIKit

class PhoneBookDAO{
    //튜플에 별명을 붙여서 DTO로 사용
    typealias PhoneRecord = (Int, String, String, String)
    
    //SQLite에 연결 및 초기화
    //lazy는 지연 생성 : 사용할 때 객체를 생성하는 것
    lazy var fmdb : FMDatabase! = {
        //1. 파일 매니저 객체를 생성
        let fileMgr = FileManager.default
        //2. 샌드박스 내 문서 디렉터리에서 데이터베이스 파일 경로를 확인
        let dirPaths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        
        let docsDir = dirPaths[0] as String
        
        let dbPath = docsDir.appending("/phonebook.sqlite")
        
        //3. 준비된 데이터베이스 파일을 바탕으로 FMDatabase 객체를 생성
        let db = FMDatabase(path: dbPath)
        return db
    }()

    //초기화 메소드와 소멸자 메소드
    init() {
        //데이터베이스에 접속
        self.fmdb.open()
    }
    
    deinit {
        //데이터베이스와의 접속 해제
        self.fmdb.close()
    }
    
    //데이터 전체를 읽어서 리턴하는 메소드
    func find() -> [PhoneRecord]{
        //읽어올 데이터를 담을 [PhoneRecord] 타입의 객체 정의
        var phoneList = [PhoneRecord]()
        do {
            //1.전화번호부 목록을 가져올 SQL 작성 및 쿼리 실행
            let sql = """
        SELECT num, name, phone, addr
        FROM phonebook
        ORDER BY num ASC
      """
            let rs = try self.fmdb.executeQuery(sql, values: nil)
        //2. 결과 집합 추출
            while rs.next() {
                let num = rs.int(forColumn: "num")
                let name = rs.string(forColumn: "name")
                let phone = rs.string(forColumn: "phone")
                let addr = rs.string(forColumn: "addr")
                // append 메소드 호출 시 아래 튜플을 괄호 없이 사용하지 않도록 주의
                phoneList.append( ( Int(num), name!, phone!, addr! ) )
            }
        } catch let error as NSError {
            NSLog("failed: \(error.localizedDescription)")
        }
        return phoneList
    }
    
    //기본키를 받아서 하나씩 데이터를 찾아오는 메소드
    func get(num : Int) -> PhoneRecord?{
        // 1. 질의 실행
        let sql =
            """
            SELECT num, name, phone, addr
            FROM phonebook
            WHERE num = ?
            """
        
        let rs = self.fmdb.executeQuery(sql, withArgumentsIn: [num])
        // 결과 집합 처리
        if let _rs = rs { // 결과 집합이 옵셔널 타입으로 반환되므로, 이를 일반 상수에 바인딩하여 해제한다.
            _rs.next()
            let num = _rs.int(forColumn: "num")
            let name = _rs.string(forColumn: "name")
            let phone = _rs.string(forColumn: "phone")
            let addr = _rs.string(forColumn: "addr")
            return (Int(num), name!, phone!, addr!)
        } else { // 결과 집합이 없을 경우 nil을 반환한다.
            return nil
        }
    }
    
    
    //데이터를 삽입하는 메소드
    func create(name:String!, phone:String!, addr:String!) -> Bool{
        do {
            let sql =
                """
                INSERT INTO phonebook (name, phone, addr)
                VALUES (?, ?, ?)
                """
            
            try self.fmdb.executeUpdate(sql, values: [name!, phone!,  addr!])
            return true
        } catch let error as NSError {
            NSLog("Insert Error : \(error.localizedDescription)")
            return false
        }
    }
    
    //데이터를 삭제하는 메소드
    func remove(num:Int) -> Bool{
        do {
            let sql = "DELETE FROM phonebook WHERE num= ? "
            try self.fmdb.executeUpdate(sql, values: [num])
            return true
        } catch let error as NSError {
            NSLog("DELETE Error : \(error.localizedDescription)")
            return false
        }
    }

}
