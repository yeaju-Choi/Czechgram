//
//  NetworkError.swift
//  Czechgram
//
//  Created by juntaek.oh on 2022/07/12.
//

import Foundation

enum NetworkError: Error {
    case transportError(Error)
    case serverError(statusCode: Int)
    case noData
    case decodingError(Error)
    case encodingError(Error)
}
