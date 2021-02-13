//
//  NetworkDispatcher.swift
//  Evaluation2021
//
//  Created by Yashika on 2/12/21.
//  Copyright © 2021 Yashika. All rights reserved.
//

import Foundation

public protocol NetworkDispatcher {
    /**
     *  Method to dispatch request.
     *  - Parameter request:    of type **RequestData**
     *  - Parameter onSuccess:   Handler for success
     *  - Parameter onError:   Handler for failure
     */
    func dispatch(request: RequestData, onSuccess: @escaping (Data) -> Void, onError: @escaping (Error) -> Void)
}
