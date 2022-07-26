//
//  ViewMyPageRepository.swift
//  Czechgram
//
//  Created by juntaek.oh on 2022/07/20.
//

import UIKit

protocol ViewMainPageRepository {

    func requestPageData(for completion: @escaping (UserPageDTO?) -> Void)
    func requestMediaData(with id: String, for completion: @escaping (UIImage?, String?) -> Void)
    func requestNextPageMediaData(with validURL: URL, for completion: @escaping (MediaDTO?) -> Void)
}
