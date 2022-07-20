//
//  ViewMyPageRepository.swift
//  Czechgram
//
//  Created by juntaek.oh on 2022/07/20.
//

import UIKit

protocol ViewMyPageRepository {

    func requestPageData(for completion: @escaping (UserPageDTO?) -> Void)
    func requestMediaData(with id: String, for completion: @escaping (UIImage?, String?) -> Void)
}
