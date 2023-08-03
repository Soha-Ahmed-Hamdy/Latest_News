//
//  AllNewsDatabaseHelper.swift
//  Latest News
//
//  Created by Soha Ahmed Hamdy on 01/08/2023.
//

import Foundation
import RealmSwift

class AllNewsDatabaseHelper{
    static let shared = AllNewsDatabaseHelper()
    private var localNewsRealm = try! Realm()
    
    func getLocalNewsDatabaseURL () -> URL? {
        return Realm.Configuration.defaultConfiguration.fileURL
    }
    
    func saveAllNews(news: LocalNewsModel){
        try! localNewsRealm.write{
            print("test save data from local")
            localNewsRealm.add(news)
        }
    }
    
    func getAllLocalNews() -> [LocalNewsModel] {
        print("test get data from local")
        return Array(localNewsRealm.objects(LocalNewsModel.self))
    }
    
    func deleteAllNews(){
        if checkIfRealmEmpty() == false{
            let objectToDelete = localNewsRealm.objects(LocalNewsModel.self)
            try! localNewsRealm.write{
                print("test delete data from local")
                localNewsRealm.delete(objectToDelete)
            }
        }
    }
    
    func checkIfRealmEmpty() -> Bool {
        let data = getAllLocalNews()
        if data.count == 0 {
            return true
        }else{
            return false
        }
    }
    
}
