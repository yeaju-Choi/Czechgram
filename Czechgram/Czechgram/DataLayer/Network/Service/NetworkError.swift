//
//  NetworkError.swift
//  Czechgram
//
//  Created by juntaek.oh on 2022/07/12.
//

import Foundation

enum NetworkError: Error {
    case noURL
    case transportError(Error)
    case serverError(statusCode: Int)
    case noData
    case decodingError
    case encodingError
}
