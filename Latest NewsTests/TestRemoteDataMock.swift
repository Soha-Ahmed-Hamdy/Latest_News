//
//  TestRemoteDataMock.swift
//  Latest NewsTests
//
//  Created by Soha Ahmed Hamdy on 31/07/2023.
//

import Foundation
import XCTest
@testable import Latest_News

final class TestRemoteDataMock: XCTestCase{
    var remoteDataMock : RemoteDataMock? = RemoteDataMock()
    func testRootDataDecoding(){
        remoteDataMock?.getNews(){ res in
            guard let result = res else{
                XCTFail()
                return
            }
            XCTAssertNotNil(result)
        }
    }
}

