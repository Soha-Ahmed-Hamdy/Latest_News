//
//  TestFavouriteViewModel.swift
//  Latest NewsTests
//
//  Created by Soha Ahmed Hamdy on 01/08/2023.
//

import Foundation
import XCTest
@testable import Latest_News


final class TestFavouriteViewModel: XCTestCase {
    var favViewModel: FavouriteViewModelProtocol?
    
    override func setUpWithError() throws {
        favViewModel = FavouriteViewModelProtocol()
    }

    override func tearDownWithError() throws {
        favViewModel = nil
    }

    func testgetAllFavs(){
        
        let expectation = expectation(description: "Waiting for the API Data")
        favViewModel?.getAllFavArticles()
        favViewModel?.bindFavouriteResultToViewController = { [weak self] in
                
            XCTAssertNotNil(self?.favViewModel?.VMFavouriteResult)
            expectation.fulfill()
        }
        waitForExpectations(timeout: 10)
    }
    
    
}

