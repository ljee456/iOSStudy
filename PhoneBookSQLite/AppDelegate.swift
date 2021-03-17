//
//  AppDelegate.swift
//  PhoneBookSQLite
//
//  Created by 202 on 2021/03/16.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    //앱이 런칭될 때 호출되는 메소드
    //앱이 시작될 때 가장 먼저 호출되는 메소드
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        //데이터베이스 파일을 생성
        let filemgr = FileManager.default
        let dirPaths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let docsDir = dirPaths[0] as String
        let databasePath = docsDir.appending("/phonebook.sqlite")
        //데이터베이스 파일이 없다면
        if !filemgr.fileExists(atPath: databasePath){
            //데이터베이스 파일 생성
            let contactDB = FMDatabase(path: databasePath)
            //데이터베이스 파일을 열면
            if contactDB.open(){
                //테이블 생성
                let sql_stmt = "create table if not exists phonebook(num integer not null primary key autoincrement, name text, phone text, addr text)"
                //테이블 생성을 실패하면
                if !contactDB.executeStatements(sql_stmt){
                    //에러 메세지
                    NSLog("Error\(contactDB.lastErrorMessage())")
                }else{
                    NSLog("테이블 생성 성공")
                }
            }else{
                //데이터베이스 파일을 열지 못하면 에러 메세지
                NSLog("Error\(contactDB.lastErrorMessage())")
            }
        }
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

