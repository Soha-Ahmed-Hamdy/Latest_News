//
//  TestRemoteDataSource.swift
//  Latest NewsTests
//
//  Created by Soha Ahmed Hamdy on 31/07/2023.
//

import Foundation
import XCTest
@testable import Latest_News


final class TestRemoteDataSource: XCTestCase {
    var remoteData : RemoteDataSourceProtocol? = RemoteDataSource()
    
    func testAllNews(){
        let expectation = expectation(description: "Waiting for the API Data")
        remoteData?.getNews() { result in
            XCTAssertNotNil(result)
            expectation.fulfill()
        }
        waitForExpectations(timeout: 10)
    }
    
}

