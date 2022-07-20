//
//  ViewMyPageRepository.swift
//  Czechgram
//
//  Created by juntaek.oh on 2022/07/20.
//

import UIKit

protocol ViewMyPageRepository {

    func requestPageData(for completion: @escaping (UserPageDTO?) -> Void)
    func requestMediaData(for completion: @escaping (UIImage?) -> Void)
}
