//
//  RequestData.swift
//  Evaluation2021
//
//  Created by Yashika on 2/12/21.
//  Copyright © 2021 Yashika. All rights reserved.
//

/**
 *  Basic http request methods
 */
import Foundation

public enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
}

/**
 *  This type can be used to construct network request that contains
 *  - path      :   Resource path(url string)
 *  - method    :   Http method call type (Optional)
 *  - params    :   Parameters that needs to be passed while making a call (Optional)
 *  - headers   :   Headers to be passed while making request (Optional)
 *  - body        :   Body to be passed while making request (Optional)
 */

public struct RequestData {
    public let path: String
    public let method: HTTPMethod
    public let params: [String: Any?]?
    public let headers: String?
    public let body: Data?
    
    public init (
        urlPath path: String,
        method: HTTPMethod = HTTPMethod.get,
        params: [String: Any?]? = nil,
        headers: String? = nil,
        body: Data? = nil
        ) {
        self.path = path
        self.method = method
        self.params = params
        self.headers = headers
        self.body = body
    }
}
