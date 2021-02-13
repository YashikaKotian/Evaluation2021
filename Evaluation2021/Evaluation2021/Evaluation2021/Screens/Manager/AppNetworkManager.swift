//
//  HomeScreenManager.swift
//  Evaluation2021
//
//  Created by Yashika on 2/13/21.
//  Copyright © 2021 Yashika. All rights reserved.
//

import Foundation

//Handle API Calls
class HomeScreenManager {
    
    static var favPhoto = [PhotoResponse]()
    
    //Fetch photos list
    func fetchAllPhotos(completionHandler : @escaping (PhotoMainResponse?) -> (), errorHandler : @escaping (Error) -> Void) {
        let path = "\(AppUrls.getPhotoList)"
        
        let req = RequestData(urlPath: path, method: .get, params: nil, headers: Credentials.apiKey, body: nil)
        
        URLSessionNetworkDispatcher.shared.dispatch(request: req, onSuccess: { (responseData: Data) in
            do {
                let result = try JSONDecoder().decode(PhotoMainResponse.self, from: responseData as Data)
                DispatchQueue.main.async {
                    completionHandler(result)
                }
            } catch let error {
                print(error)
                completionHandler(nil)
            }
        }) { (error : Error) in
            errorHandler(error)
        }
    }
    
    //Fetch Photo detail
    func GetEachPhoto(id: Double, completionHandler : @escaping (PhotoResponse?) -> (), errorHandler : @escaping (Error) -> Void) {
        let path = "\(AppUrls.getPhotoDetail)\(id)"
        
        let req = RequestData(urlPath: path, method: .get, params: nil, headers: Credentials.apiKey, body: nil)
        
        URLSessionNetworkDispatcher.shared.dispatch(request: req, onSuccess: { (responseData: Data) in
            do {
                let result = try JSONDecoder().decode(PhotoResponse.self, from: responseData)
                DispatchQueue.main.async {
                    completionHandler(result)
                }
            } catch let error {
                print(error)
                completionHandler(nil)
            }
        }) { (error : Error) in
            errorHandler(error)
        }
    }
    
    //Fetch videos list
    func fetchVideos(completionHandler : @escaping (VideoMainResponse?) -> (), errorHandler : @escaping (Error) -> Void) {
        let path = "\(AppUrls.getVideoList)"
        
        let req = RequestData(urlPath: path, method: .get, params: nil, headers: Credentials.apiKey, body: nil)
        
        URLSessionNetworkDispatcher.shared.dispatch(request: req, onSuccess: { (responseData: Data) in
            do {
                let result = try JSONDecoder().decode(VideoMainResponse.self, from: responseData)
                DispatchQueue.main.async {
                    completionHandler(result)
                }
            } catch let error {
                print(error)
                completionHandler(nil)
            }
        }) { (error : Error) in
            errorHandler(error)
        }
    }
    
    //Fetch video detail
    func GetEachVideo(id: Double, completionHandler : @escaping (VideoResponse?) -> (), errorHandler : @escaping (Error) -> Void) {
        let path = "\(AppUrls.getVideoDetail)\(id)"
        
        let req = RequestData(urlPath: path, method: .get, params: nil, headers: Credentials.apiKey, body: nil)
        
        URLSessionNetworkDispatcher.shared.dispatch(request: req, onSuccess: { (responseData: Data) in
            do {
                let result = try JSONDecoder().decode(VideoResponse.self, from: responseData)
                DispatchQueue.main.async {
                    completionHandler(result)
                }
            } catch let error {
                print(error)
                completionHandler(nil)
            }
        }) { (error : Error) in
            errorHandler(error)
        }
    }
    
    //Photo search
    func fetchPhotoSearch(text: String, completionHandler : @escaping (PhotoMainResponse?) -> (), errorHandler : @escaping (Error) -> Void) {
        let path = "\(AppUrls.searchPhoto)\(text)"
        
        let req = RequestData(urlPath: path, method: .get, params: nil, headers: Credentials.apiKey, body: nil)
        
        URLSessionNetworkDispatcher.shared.dispatch(request: req, onSuccess: { (responseData: Data) in
            do {
                let result = try JSONDecoder().decode(PhotoMainResponse.self, from: responseData)
                DispatchQueue.main.async {
                    completionHandler(result)
                }
            } catch let error {
                print(error)
                completionHandler(nil)
            }
        }) { (error : Error) in
            errorHandler(error)
        }
    }
    
    //Video Search
    func fetchVideoSearch(text: String, completionHandler : @escaping (VideoMainResponse?) -> (), errorHandler : @escaping (Error) -> Void) {
        let path = "\(AppUrls.searchVideo)\(text)"
        
        let req = RequestData(urlPath: path, method: .get, params: nil, headers: Credentials.apiKey, body: nil)
        
        URLSessionNetworkDispatcher.shared.dispatch(request: req, onSuccess: { (responseData: Data) in
            do {
                let result = try JSONDecoder().decode(VideoMainResponse.self, from: responseData)
                DispatchQueue.main.async {
                    completionHandler(result)
                }
            } catch let error {
                print(error)
                completionHandler(nil)
            }
        }) { (error : Error) in
            errorHandler(error)
        }
    }
    
}
