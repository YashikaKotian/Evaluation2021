//
//  SearchResponseModel.swift
//  Evaluation2021
//
//  Created by Yashika on 2/13/21.
//  Copyright © 2021 Yashika. All rights reserved.
//

import Foundation

struct SearchPhotoResponse: Codable {
    let total_results: Double?
    let page: Int?
    let per_page: Int?
    let photos: [PhotoResponse]?
    let next_page: String?
}

struct SearchVideoResponse: Codable {
    let page: Int?
    let per_page: Int?
    let total_results: Double?
    let url: String?
    let videos: [VideoResponse]?
    let next_page: String?
}
