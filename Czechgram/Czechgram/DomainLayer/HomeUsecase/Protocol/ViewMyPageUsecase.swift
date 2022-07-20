//
//  ViewMyPageUsecase.swift
//  Czechgram
//
//  Created by juntaek.oh on 2022/07/20.
//

import Foundation

protocol ViewMyPageUsecase {

    func executeUserPage(completion: @escaping (UserPageEntity) -> Void)
    func executeMediaImage(with imageEntity: MediaImageEntity, completion: @escaping (MediaImageEntity) -> Void)

}
