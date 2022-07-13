//
//  Endpontable.swift
//  Czechgram
//
//  Created by 최예주 on 2022/07/12.
//

import Foundation

protocol EndPontable {
    var scheme: String {get}
    var host: String {get}
    var path: String? {get}
    var httpMethod: HTTPMethod {get}
    var contentType: [String: String]? {get}
    var queryItems: [URLQueryItem]? {get}
    var url: URL? {get}
}
