//
//  ViewDefaultMyPageUsecase.swift
//  Czechgram
//
//  Created by juntaek.oh on 2022/07/20.
//

import Foundation

final class ViewDefaultMyPageUsecase: ViewMyPageUsecase {

    let myPageRepository: ViewMyPageRepository = ViewDefaultMyPageRepository()

    func execute() {
        myPageRepository.requestPageData { userPageDTO in
            guard let validDTO = userPageDTO else { return }

        }
    }
}
