//
//  NetworkServiceable.swift
//  Czechgram
//
//  Created by juntaek.oh on 2022/07/12.
//

import Foundation

protocol NetworkServiceable {
    typealias CompletionHandler = (Result<Data, NetworkError>) -> Void
    static func request(endPoint: EndPoint, completion: @escaping CompletionHandler)
}
