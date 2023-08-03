//
//  TestRemoteDataViewModel.swift
//  Latest NewsTests
//
//  Created by Soha Ahmed Hamdy on 31/07/2023.
//

import Foundation
import XCTest
//import RealmSwift
@testable import Latest_News


final class TestHomeViewModel: XCTestCase {
    var remoteData : RemoteDataSourceProtocol? = RemoteDataSource()
    var homeViewModel: HomeViewModelProtocol?
    
    override func setUpWithError() throws {
        homeViewModel = HomeViewModel(remote: remoteData!)
    }

    override func tearDownWithError() throws {
        homeViewModel = nil
    }

    func testgetAllNews(){
        
        let expectation = expectation(description: "Waiting for the API Data")
        homeViewModel?.getAllNews()
        homeViewModel?.bindNewsResultToViewController = { [weak self] in
                
            XCTAssertNotNil(self?.homeViewModel?.VMResult)
            expectation.fulfill()
        }
        waitForExpectations(timeout: 10)
    }
    
    func testgetAllLocalNews(){
        
        let expectation = expectation(description: "Waiting for the API Data")
        homeViewModel?.getLocalNews()
        homeViewModel?.bindLocalNewsResultToViewController = { [weak self] in
                
            XCTAssertNotNil(self?.homeViewModel?.VMLocalNewsResult )
            expectation.fulfill()
        }
        waitForExpectations(timeout: 10)
    }
    
    
}
