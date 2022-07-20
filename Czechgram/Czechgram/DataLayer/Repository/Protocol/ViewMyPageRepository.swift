//
//  ViewMyPageRepository.swift
//  Czechgram
//
//  Created by juntaek.oh on 2022/07/20.
//

import Foundation

protocol ViewMyPageRepository {

    func requestPageData(for completion: @escaping (UserPageDTO?) -> Void)
}
