//
//  DatabaseHelper.swift
//  Latest News
//
//  Created by Soha Ahmed Hamdy on 31/07/2023.
//

import Foundation
import RealmSwift

class DatabaseHelper{
    static let shared = DatabaseHelper()
    private var realm = try! Realm()
    
    func getDatabaseURL () -> URL? {
        return Realm.Configuration.defaultConfiguration.fileURL
    }
    
    func saveArticle(article: FavouriteModel){
        try! realm.write{
            realm.add(article)
        }
    }
    
    func getAllFavouriteArticle() -> [FavouriteModel]{
        return Array(realm.objects(FavouriteModel.self))
    }
    
    func deleteArticle(article: FavouriteModel){
        let objectToDelete = realm.objects(FavouriteModel.self).where {
            $0.title == article.title
        }.first!
        try! realm.write{
            realm.delete(objectToDelete)
        }
    }
    
    func checkIfFav(title : String) ->  Bool{
        let result = (Array(realm.objects(FavouriteModel.self)).filter( {($0.title == title )} ))
        return result.count == 0 ? false : true
    }
    
}
