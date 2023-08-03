//
//  Mapper.swift
//  Latest News
//
//  Created by Soha Ahmed Hamdy on 01/08/2023.
//
import Foundation
class Mapper{
    
    static func MapFavToArticle(favouriteItem: FavouriteModel) -> Article {
        return Article(source: Source(name: favouriteItem.source), author: favouriteItem.author, title: favouriteItem.title, description: favouriteItem.descrip, url: favouriteItem.url, urlToImage: favouriteItem.urlToImage, publishedAt: favouriteItem.publishedAt, content: favouriteItem.content)
    }
    
    static func MapArticleToFav(article: Article) -> FavouriteModel {
        return FavouriteModel(source: article.source?.name ?? "", auther: article.author ?? "", title: article.title ?? "", descrip: article.description ?? "", url: article.url ?? "", urlToImage: article.urlToImage ?? "", publishedAt: article.publishedAt ?? "", content: article.content ?? "")
    }
    
    static func articleToLocalArticle(article: Article) -> LocalArticle {
        return LocalArticle(source: article.source?.name ?? "", auther: article.author ?? "", title: article.title ?? "", descrip: article.description ?? "", url: article.url ?? "", urlToImage: article.urlToImage ?? "", publishedAt: article.publishedAt ?? "", content: article.content ?? "")
    }
    
    static func articleListToLocalArticleList(articlesList: [Article]) -> [LocalArticle]{
        var localArticles : [LocalArticle] = []
        articlesList.forEach({ article in
            localArticles.append(articleToLocalArticle(article: article))
        })
        return localArticles
    }

}

