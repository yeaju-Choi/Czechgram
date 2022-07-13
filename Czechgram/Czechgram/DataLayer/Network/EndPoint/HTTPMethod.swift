//
//  HTTPMethod.swift
//  Czechgram
//
//  Created by 최예주 on 2022/07/12.
//

import Foundation

enum HTTPMethod: String {
    case get, post

    var value: String {
        self.rawValue.uppercased()
    }
}
