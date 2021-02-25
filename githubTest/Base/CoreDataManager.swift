//
//  CoreDataManager.swift
//  githubTest
//
//  Created by 叶绿青 on 2021/2/25.
//  Copyright © 2021 叶绿青. All rights reserved.
//

import Foundation

import UIKit
import CoreData

class CoreDataManager: NSObject {
    
    // 单例
    static let shared = CoreDataManager()
    
    
    // 拿到AppDelegate中创建好了的NSManagedObjectContext
    lazy var context: NSManagedObjectContext = {
        let context = ((UIApplication.shared.delegate) as! AppDelegate).context
        return context
    }()
    
    // 更新数据
    private func saveContext() {
        do {
            try context.save()
        } catch {
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
    }
    
    func random(_ count: Int, _ isLetter: Bool = false) -> String {
        
        var ch: [CChar] = Array(repeating: 0, count: count)
        for index in 0..<count {
            
            var num = isLetter ? arc4random_uniform(58)+65:arc4random_uniform(75)+48
            if num>57 && num<65 && isLetter==false { num = num%57+48 }
            else if num>90 && num<97 { num = num%90+65 }
            
            ch[index] = CChar(num)
        }
        
        return String(cString: ch)
    }
    
    /*************通知消息持久化数据处理 start****************/
    // 增加数据
    func saveRequestlistWith(_ data: NSDictionary) {
        
        let list = NSEntityDescription.insertNewObject(forEntityName: "RequestList", into: context) as! RequestList
        let timeInterval: TimeInterval = Date().timeIntervalSince1970
        let timeStamp = Int(timeInterval)
        let objectId =  "\(timeStamp)\(random(6))"
        list.rid = objectId
        list.title = "\(Date())"
        list.result_txt = "\(data)"

        list.result_time = Date()
        saveContext()
    }
    
    func getAllRequestlist() -> [RequestList] {
        
        let fetchRequest: NSFetchRequest = RequestList.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "1 == 1  ")
        
        do {
            let result = try context.fetch(fetchRequest)
            return result
        } catch {
            fatalError();
        }
    }
    
    func getTopNewResult() -> RequestList {
        
        let fetchRequest: NSFetchRequest = RequestList.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "1 == 1 ")
        var topResult:RequestList = RequestList.init()

        do {
            let result = try context.fetch(fetchRequest)
            if result.count > 0 {
                topResult =  result[0]
            }
        } catch {
            fatalError();
        }
        return topResult
        
    }
}


