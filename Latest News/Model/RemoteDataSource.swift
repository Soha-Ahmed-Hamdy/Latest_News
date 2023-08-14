//
//  RemoteDataSource.swift
//  Latest News
//
//  Created by Soha Ahmed Hamdy on 30/07/2023.
//

import Foundation


protocol RemoteDataSourceProtocol{
    func getNews(compilitionHandler: @escaping (AllNews?) -> Void)
}

class RemoteDataSource: RemoteDataSourceProtocol{
    func getNews(compilitionHandler: @escaping (AllNews?) -> Void) {
        let url = URL(string: "https://newsapi.org/v2/top-headlines?country=us&apiKey=31a5189a0fe7447b9f0a282ade9120e9")
        guard let newUrl = url else {
            return
        }
        let request = URLRequest(url: newUrl)
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: request){ data,response , error in
            do{
                let result = try JSONDecoder().decode(AllNews.self, from: data ?? Data())
                compilitionHandler(result)
            } catch let error{
                print("error in api model \(error)")
                compilitionHandler(nil)
            }
        }
        task.resume()
    }
}

