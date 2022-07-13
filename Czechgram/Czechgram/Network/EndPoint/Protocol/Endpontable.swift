//
//  Endpontable.swift
//  Czechgram
//
//  Created by 최예주 on 2022/07/12.
//

import Foundation

protocol EndPontable {
    var base: String {get}
    var path: String? {get}
    var httpMethod: HTTPMethod {get}
    var contentType: [String: String]? {get}
    var parameter: [String: String]? {get}
}
