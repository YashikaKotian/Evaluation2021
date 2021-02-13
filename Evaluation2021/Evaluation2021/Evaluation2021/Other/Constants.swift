//
//  Constants.swift
//  Evaluation2021
//
//  Created by Yashika on 2/13/21.
//  Copyright © 2021 Yashika. All rights reserved.
//

import Foundation
import UIKit


let iPad: Bool = (UIDevice.current.userInterfaceIdiom == .pad)

//API key
struct Credentials {
    static let apiKey = "563492ad6f9170000100000166c68c7147ef413fa42d2bf8169cc903"
}

//API urls
struct AppUrls {
    static let getPhotoList = "https://api.pexels.com/v1/curated"
    static let getVideoList = "https://api.pexels.com/videos/popular"
    static let getPhotoDetail = "https://api.pexels.com/v1/photos/"
    static let getVideoDetail = "https://api.pexels.com/videos/videos/"
    static let searchPhoto = "https://api.pexels.com/v1/search?query="
    static let searchVideo = "https://api.pexels.com/videos/search?query="
}

struct Colors {
    static let unselectedTabColor = UIColor.colorFromHexString("#230735")
    static let selectedTabColor = UIColor.colorFromHexString("#E81244")
}
