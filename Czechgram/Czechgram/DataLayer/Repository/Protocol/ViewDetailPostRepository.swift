//
//  ViewDetailPostRepository.swift
//  Czechgram
//
//  Created by juntaek.oh on 2022/07/25.
//

import UIKit

protocol ViewDetailPostRepository {

    var networkService: NetworkServiceable { get }
    func requestChildrenData(with id: String, for completion: @escaping (MediaDTO) -> Void)
    func requestChildrenImage(with id: String, for completion: @escaping (UIImage?, String?) -> Void)
}
