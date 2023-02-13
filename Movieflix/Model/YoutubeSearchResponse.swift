//
//  YoutubeSearchResponse.swift
//  Movieflix
//
//  Created by Macbook Pro on 12.02.2023.
//

import Foundation

struct YoutubeSearchResponse : Codable {
    let items: [VideoElement]
}

struct VideoElement: Codable {
    let id : IdVideoElement
}

struct IdVideoElement: Codable {
    let kind: String
    let videoId: String
}
