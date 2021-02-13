//
//  PhotoResponse.swift
//  Evaluation2021
//
//  Created by Yashika on 2/13/21.
//  Copyright © 2021 Yashika. All rights reserved.
//

import Foundation

struct PhotoMainResponse: Codable {
    var page: Int?
    var per_page: Int?
    var photos: [PhotoResponse]?
    var total_results: Double?
    var next_page: String?
}

struct PhotoResponse: Codable {
    var id: Double?
    var width: Double?
    var height: Double?
    var url: String?
    var photographer: String?
    var avg_color: String?
    var photographer_url: String?
    var src: SourceInfo?
    var liked: Bool?
}

struct SourceInfo: Codable {
    var original: String?
    var large2x: String?
    var large: String?
    var medium: String?
    var small: String?
    var landscape: String?
    var portrait: String?
    var tiny: String?
}
