//
//  ViewDetailPostUsecase.swift
//  Czechgram
//
//  Created by juntaek.oh on 2022/07/25.
//

import Foundation

protocol ViewDetailPostUsecase {

    func executePostData(with id: String, completion: @escaping ([MediaImageEntity]) -> Void)
}
