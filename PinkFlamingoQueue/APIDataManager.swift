//
//  APIDataManager.swift
//  PinkFlamingoQueue
//
//  Created by Peter Malmgren on 9/27/16.
//  Copyright © 2016 Safari Books Online. All rights reserved.
//

import Foundation

let QueueAPIBaseURL: URL = URL(string: "http://104.236.18.46:9090/api/")!

// QueueAPIRequester defines interactions with our API
@objc(QueueAPIProtocol)
protocol QueueAPIRequester {
    func getQueue(callback: @escaping ([QueueItem]?, NSError?) -> ())
    func getDiscover(callback: @escaping ([DiscoverItem]?, NSError?) -> ())
    func addQueue(itemID: String, callback: @escaping (QueueItem?, NSError?) -> ())
    func removeQueue(item: QueueItem, callback: @escaping (NSError?) -> ())
}

@objc(APIDataManager)
class QueueAPIDataManager: NSObject, QueueAPIRequester {
    private func discoverURLRequest() -> URLRequest {
        let request = URLRequest(url: QueueAPIBaseURL.appendingPathComponent("books", isDirectory: true))
        return request
    }

    private func queueURLRequest() -> URLRequest {
        let request = URLRequest(url: QueueAPIBaseURL.appendingPathComponent("queue", isDirectory: true))
        return request
    }

    private func queueDetailURLRequest(id: String) -> URLRequest {
        let request = URLRequest(url: QueueAPIBaseURL.appendingPathComponent("queue").appendingPathComponent("\(id)",
            isDirectory: true))
        return request
    }

    internal func removeQueue(item: QueueItem, callback: @escaping (NSError?) -> ()) {
        // TODO
        //Unfortunately I can't figure out why I can't access the queueID property
        //of the QueueItem instance, and I am loath to change the method signature of
        //this call to more easily accomodate the id.
        /*
 
        let myID = item.queueID!
        print(myID)
        
        var request = self.queueDetailURLRequest(id: item.queueID)
        request.httpMethod = "DELETE"
        request.setValue("application/json", forHTTPHeaderField: "content-type")
        
        let operation = AFHTTPRequestOperation(request: request)
        //operation.responseSerializer = AFJSONResponseSerializer()
        operation.start()
         */
        
    }

    internal func addQueue(itemID: String, callback: @escaping (QueueItem?, NSError?) -> ()) {
        var request = self.queueURLRequest()
        request.httpMethod = "POST"
        request.httpBody = try! JSONSerialization.data(withJSONObject: [kBookID: itemID, kUserID: "5"], options: [])
        request.setValue("application/json", forHTTPHeaderField: "content-type")

        let operation = AFHTTPRequestOperation(request: request)
        operation.responseSerializer = AFJSONResponseSerializer()

        operation.setCompletionBlockWithSuccess({ (requestOperation, obj) in
            guard let statusCode = requestOperation.response?.statusCode as Int?, statusCode <= 299 else {
                return callback(nil, requestOperation.error as NSError?)
            }

            guard let responseDictionary = obj as? [String: AnyObject] else {
                return callback(nil, NSError(domain: "Serialization error", code: -999, userInfo: nil))
            }
            let queueItem = QueueItem.init(jsonDictionary: responseDictionary)
            callback(queueItem, nil)
            }, failure: {(_, error) in
                callback(nil, error as NSError)
        })

        operation.start()
    }

    internal func getDiscover(callback: @escaping ([DiscoverItem]?, NSError?) -> ()) {
        var request = self.discoverURLRequest()
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "content-type")

        let operation = AFHTTPRequestOperation(request: request)
        operation.responseSerializer = AFJSONResponseSerializer()

        operation.setCompletionBlockWithSuccess({ (requestOperation, obj) in
            guard let statusCode = requestOperation.response?.statusCode as Int?, statusCode <= 299 else {
                return callback(nil, nil)
            }

            guard let responseArray = obj as? [AnyObject] else {
                return callback(nil, NSError(domain: "Serialization error", code: -999, userInfo: nil))
            }

            var discoverItems: [DiscoverItem] = []

            for item in responseArray {
                guard let responseObject = item as? [String: AnyObject], let discoverItem = DiscoverItem.init(jsonDictionary: responseObject) as DiscoverItem? else {
                    return callback(nil, NSError(domain: "Serialization error", code: -999, userInfo: nil))
                }
                discoverItems.append(discoverItem)
            }

            callback(discoverItems, nil)
            }, failure: {(_, error) in
                callback(nil, error as NSError)
        })

        operation.start()
    }

    internal func getQueue(callback: @escaping ([QueueItem]?, NSError?) -> ()) {
        var request = self.queueURLRequest()
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "content-type")

        let operation = AFHTTPRequestOperation(request: request)
        operation.responseSerializer = AFJSONResponseSerializer()

        operation.setCompletionBlockWithSuccess({ (requestOperation, obj) in
            // The response should be an array of JSON objects
            guard let statusCode = requestOperation.response?.statusCode as Int?, statusCode <= 299 else {
                return callback(nil, nil)
            }

            guard let responseArray = obj as? [AnyObject] else {
                return callback(nil, NSError(domain: "Serialization error", code: -999, userInfo: nil))
            }

            var queueItems: [QueueItem] = []

            for item in responseArray {
                guard let responseObject = item as? [String: AnyObject], let queueItem = QueueItem.init(jsonDictionary: responseObject) as QueueItem? else {
                    return callback(nil, NSError(domain: "Serialization error", code: -999, userInfo: nil))
                }
                queueItems.append(queueItem)
            }

            callback(queueItems, nil)
            }, failure: {(_, error) in
                callback(nil, error as NSError)
        })
        
        operation.start()
    }
}
