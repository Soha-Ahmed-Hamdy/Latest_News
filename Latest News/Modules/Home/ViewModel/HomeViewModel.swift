//
//  RemoteDataViewModel.swift
//  Latest News
//
//  Created by Soha Ahmed Hamdy on 30/07/2023.
//

import Foundation

protocol HomeViewModelProtocol{
    var bindNewsResultToViewController : (()->()){get set}
    var bindLocalNewsResultToViewController : (()->()){get set}
    var VMResult : AllNews?{get set}
    var VMLocalNewsResult : LocalNewsModel?{get set}
    func getAllNews()
    func getLocalNews()
    func saveLocalNews(news :LocalNewsModel)
    func deleteLocalNews()
}

class HomeViewModel: HomeViewModelProtocol{
    
    var remote : RemoteDataSourceProtocol?
    init(remote: RemoteDataSourceProtocol) {
        self.remote = remote
    }
    
    var bindNewsResultToViewController : (()->()) = {}
    
    var VMResult : AllNews?{
        didSet{
            bindNewsResultToViewController()
        }
    }
    
    var bindLocalNewsResultToViewController : (()->()) = {}
    
    var VMLocalNewsResult : LocalNewsModel?{
        didSet{
            bindLocalNewsResultToViewController()
        }
    }
    
    func getAllNews(){
        remote?.getNews(){ res in
            guard let result = res else { return }
            self.VMResult = result
        }
    }
}

extension HomeViewModel{
    
    func getLocalNews(){
        self.VMLocalNewsResult = AllNewsDatabaseHelper.shared.getAllLocalNews().first ?? LocalNewsModel()
    }
    
    func saveLocalNews(news :LocalNewsModel){
        AllNewsDatabaseHelper.shared.saveAllNews(news: news)
    }
    
    func deleteLocalNews(){
        AllNewsDatabaseHelper.shared.deleteAllNews()
    }
    
}



