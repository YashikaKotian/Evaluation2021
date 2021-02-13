//
//  RequestType.swift
//  Evaluation2021
//
//  Created by Yashika on 2/12/21.
//  Copyright © 2021 Yashika. All rights reserved.
//

import Foundation
/**
 *  **RequestType** can be extended to simplify request object construction during call.
 *  This can contain,
 *  - responseType  :   Type of response object that is expected
 *  - data          :   Request data that are being passed
 */

public protocol RequestType {
    associatedtype responseType: Codable
    var data: RequestData { get set}
}

public extension RequestType {
    /**
     *  This method can be executed on RequestType instance to instatiate network call.
     *  This method takes,
     * - Parameter dispatcher:   Protocol type NetworkDispatcher
     * - Parameter onSuccess:   Handler for success
     * - Parameter onError:   Handler for failure
     */
    func execute (
        dispatcher: NetworkDispatcher = URLSessionNetworkDispatcher.shared,
        onSuccess: @escaping (responseType) -> Void,
        onError: @escaping (Error) -> Void
        ) {
        DispatchQueue.global().async {
            dispatcher.dispatch(
                request: self.data,
                onSuccess: { (responseData: Data) in
                    do {
                        let result = try JSONDecoder().decode(responseType.self, from: responseData)
                        DispatchQueue.main.async {
                            onSuccess(result)
                        }
                    } catch let error {
                            onError(error)
                    }
            },
                onError: { (error: Error) in
                        onError(error)
            }
            )
        }
    }
}
