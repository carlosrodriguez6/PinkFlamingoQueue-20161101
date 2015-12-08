//
//  QueueAPIDataManagerTest.swift
//  PinkFlamingoQueue
//
//  Created by Peter Malmgren on 9/27/16.
//  Copyright © 2016 Safari Books Online. All rights reserved.
//

import Foundation
import XCTest
@testable import PinkFlamingoQueue

class QueueAPIDataManagerTestCase: XCTestCase {
    var dataManager: QueueAPIDataManager?

    override func setUp() {
        super.setUp()
        dataManager = QueueAPIDataManager()
        setUpHTTPMocks()
    }

    override func tearDown() {
        OHHTTPStubs.removeAllStubs()
        dataManager = nil
        super.tearDown()
    }

    func testFetchesDiscoverData() {
        // the API data manager should get the discover data from the API
        let expectation = self.expectation(description: "Discover list GET expectation")

        dataManager!.getDiscover { (discoverItems, error) in
            expectation.fulfill()
            XCTAssertEqual(discoverItems?.count, 7)
        }

        waitForExpectations(timeout: 1.0) { (error) in
            XCTAssertNil(error)
        }
    }

    func testFetchesQueueData() {
        // the API data manager should get the queue data from the api
        let expectation = self.expectation(description: "Queue list GET expectation")
        dataManager!.getQueue { (queue, error) in
            expectation.fulfill()
            XCTAssertEqual(queue?.count, 2)
            XCTAssertNil(error)
        }

        waitForExpectations(timeout: 1.0) { (error) in
            XCTAssertNil(error)
        }
    }

    func testAddsToQueue() {
        // the API data manager should add an item to the queue
        let expectation = self.expectation(description: "Queue add POST expectation")
        dataManager!.addQueue(itemID: "12345") { (queueItem, error) in
            expectation.fulfill()
            XCTAssertNotNil(queueItem)
            XCTAssertNil(error)
        }

        waitForExpectations(timeout: 1.0) { (error) in
            XCTAssertNil(error)
        }
    }

    func testAddToQueueFailure() {
        // addToQueue should handle failure
        let expectation = self.expectation(description: "Queue add POST failure expectation")
        OHHTTPStubs.removeAllStubs()
        OHHTTPStubs.stubRequests(passingTest: { (request) -> Bool in
            return request.url?.lastPathComponent == "queue"
            }, withStubResponse: { (request) -> OHHTTPStubsResponse in
                return OHHTTPStubsResponse(data: try! JSONSerialization.data(withJSONObject: ["error": "there was a server error"], options: []), statusCode: 500, headers: ["Content-Type": "application/json"])
        })

        dataManager!.addQueue(itemID: "12345") { (queueItem, error) in
            expectation.fulfill()
            XCTAssertNil(queueItem)
            XCTAssertEqual(error!.code, 500)
        }

        waitForExpectations(timeout: 1.0) { (error) in
            XCTAssertNil(error)
        }
    }

    private func setUpHTTPMocks() {
        OHHTTPStubs.stubRequests(passingTest: { (request) -> Bool in
            return request.url?.lastPathComponent == "books"
            }, withStubResponse: { (request) -> OHHTTPStubsResponse in
                let fixture = Bundle(for: type(of: self)).path(forResource: "DiscoverItems", ofType: "json")

                return OHHTTPStubsResponse(fileAtPath: fixture!, statusCode: 200, headers: ["Content-Type": "application/json"])
        })

        OHHTTPStubs.stubRequests(passingTest: { (request) -> Bool in
            return request.url?.lastPathComponent == "queue"
            }, withStubResponse: { (request) -> OHHTTPStubsResponse in
                var fixture: String
                if request.httpMethod == "POST" || request.httpMethod == "DELETE" {
                    fixture = Bundle(for: type(of: self)).path(forResource: "QueueItem", ofType: "json")!
                } else {
                    fixture = Bundle(for: type(of: self)).path(forResource: "QueueItems", ofType: "json")!
                }

                return OHHTTPStubsResponse(fileAtPath: fixture, statusCode: 200, headers: ["Content-Type": "application/json"])
        })
    }
}
