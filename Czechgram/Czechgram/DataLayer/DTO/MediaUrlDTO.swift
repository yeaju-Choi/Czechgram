//
//  MediaUrlDTO.swift
//  Czechgram
//
//  Created by 최예주 on 2022/07/20.
//

import Foundation

struct MediaUrlDTO: Codable {
    let id: String
    let mediaType: MediaType
    let mediaUrl: String
    let thumbnailUrl: String?
    let timestamp: String

    enum CodingKeys: String, CodingKey {
        case id
        case mediaType = "media_type"
        case mediaUrl = "media_url"
        case thumbnailUrl = "thumbnail_url"
        case timestamp
    }
}

enum MediaType: String, Codable {
    case Image = "IMAGE"
    case Video = "VIDEO"
    case CarouselAlBum = "CAROUSEL_ALBUM"
}
