//
//  VideoResponseModel.swift
//  Evaluation2021
//
//  Created by Yashika on 2/13/21.
//  Copyright © 2021 Yashika. All rights reserved.
//

import Foundation

struct VideoMainResponse: Codable {
    var page: Int?
    var per_page: Int?
    var videos: [VideoResponse]?
    var total_results: Double?
    var next_page: String?
}

struct VideoResponse: Codable {
    var id: Double?
    var width: Double?
    var height: Double?
    var url: String?
    var image: String?
    var duration: Double?
    var user: UserInfo?
    var video_files: [VideoInfo]?
}

struct UserInfo: Codable {
    var id: Double?
    var name: String?
    var url: String?
}

struct VideoInfo: Codable {
    var id: Double?
    var quality: String?
    var file_type: String?
    var width: Double?
    var height: Double?
    var link: String?
    
}
