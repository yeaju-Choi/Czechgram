//
//  MediaDTO.swift
//  Czechgram
//
//  Created by juntaek.oh on 2022/07/20.
//

import Foundation

// MARK: - Media
struct MediaDTO: Codable {
    let mediaIDs: [MediaID]
    let paging: MediaPagingDTO

    enum CodingKeys: String, CodingKey {
        case mediaIDs = "data"
        case paging
    }
}

// MARK: - Datum
struct MediaID: Codable {
    let id: String
}
