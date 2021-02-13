//
//  GenericRequestResponseTypes.swift
//  Evaluation2021
//
//  Created by Yashika on 2/12/21.
//  Copyright © 2021 Yashika. All rights reserved.
//

/// Generic request type

struct Request<T: Codable>: RequestType {
    typealias responseType = Response<T>
    var data: RequestData
    init(data: RequestData) {
        self.data = data
    }
}


/// Generic response type

struct Response<T: Codable>: Codable {
    var code, message: String?
    var data: ResponseData<T>
}

struct ResponseData<T: Codable>: Codable {
    var sectionId: String?
    var datalist: [T]?
    
    enum CodingKeys: String, CodingKey {
        case sectionId = "section_id"
        case datalist
    }
}


/// Generic request Manager

class RequestManager {
    
    static func invokeService<T: Codable>(requestData: RequestData, responseType type: T.Type, onSuccess handler: @escaping (Response<T>?) -> (), onError errorHandler: @escaping (Error) -> ()) {
        Request(data: requestData).execute(onSuccess: handler, onError: errorHandler)
    }
}
