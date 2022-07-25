//
//  MediaPagingDTO.swift
//  Czechgram
//
//  Created by juntaek.oh on 2022/07/20.
//

import Foundation

// MARK: - Paging
struct MediaPagingDTO: Codable {
    let next: String?
    let previous: String?
}
