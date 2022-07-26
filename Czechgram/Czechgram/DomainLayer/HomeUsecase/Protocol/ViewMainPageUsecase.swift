//
//  ViewMyPageUsecase.swift
//  Czechgram
//
//  Created by juntaek.oh on 2022/07/20.
//

import Foundation

protocol ViewMainPageUsecase {

    func executeUserPage(completion: @escaping (UserPageEntity) -> Void)
    func executeMediaImage(with imageEntity: MediaImageEntity, completion: @escaping (MediaImageEntity) -> Void)
    func executeNextMediaImage(with nextImageSection: String?, completion: @escaping (MediaEntity?) -> Void)
}
