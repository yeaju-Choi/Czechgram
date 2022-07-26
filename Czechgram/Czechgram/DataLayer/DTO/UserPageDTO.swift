//
//  UserPageDTO.swift
//  Czechgram
//
//  Created by juntaek.oh on 2022/07/20.
//

import Foundation

struct UserPageDTO: Codable {
    let username: String
    let mediaCount: Int
    let media: MediaDTO
    let id: String

    enum CodingKeys: String, CodingKey {
        case username
        case mediaCount = "media_count"
        case media, id
    }
}
