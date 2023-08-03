//
//  FavouriteModel.swift
//  Latest News
//
//  Created by Soha Ahmed Hamdy on 31/07/2023.
//

import Foundation
import RealmSwift

class FavouriteModel : Object{
    
    @Persisted var source: String
    @Persisted var author: String
    @Persisted var title : String
    @Persisted var descrip: String
    @Persisted var url: String
    @Persisted var urlToImage: String
    @Persisted var publishedAt: String
    @Persisted var content: String
    
    convenience init (source : String, auther : String, title : String, descrip: String,url: String, urlToImage: String, publishedAt: String, content: String){
        self.init()
        self.author = auther
        self.source = source
        self.title = title
        self.descrip = descrip
        self.url = url
        self.urlToImage = urlToImage
        self.publishedAt = publishedAt
        self.content = content
    }
}
