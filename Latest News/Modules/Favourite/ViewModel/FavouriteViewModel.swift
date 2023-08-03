//
//  FavouriteViewModel.swift
//  Latest News
//
//  Created by Soha Ahmed Hamdy on 31/07/2023.
//

import Foundation

protocol FavouriteViewModelProtocol{
    var bindFavouriteResultToViewController : (()->()){get set}
    var VMFavouriteResult : [FavouriteModel]?{get set}
    func getAllFavArticles()
    func saveFavArticle(article :FavouriteModel)
    func deleteFavArticle(article :FavouriteModel)
    func checkIfFavourite(title :  String) -> Bool
}

class FavouriteViewModel : FavouriteViewModelProtocol{
    
    var bindFavouriteResultToViewController : (()->()) = {}
    
    var VMFavouriteResult : [FavouriteModel]?{
        didSet{
            bindFavouriteResultToViewController()
        }
    }
    
    
    func getAllFavArticles(){
        self.VMFavouriteResult = DatabaseHelper.shared.getAllFavouriteArticle()
    }
    
    func saveFavArticle(article :FavouriteModel){
        DatabaseHelper.shared.saveArticle(article: article)
    }
    
    func deleteFavArticle(article :FavouriteModel){
        DatabaseHelper.shared.deleteArticle(article: article)
    }
    
    func checkIfFavourite(title :  String) -> Bool{
        let result = DatabaseHelper.shared.checkIfFav(title: title)
        return result
    }
    
}

