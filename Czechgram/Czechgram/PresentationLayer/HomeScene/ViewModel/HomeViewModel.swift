//
//  HomeViewModel.swift
//  Czechgram
//
//  Created by juntaek.oh on 2022/07/20.
//

import Foundation

final class HomeViewModel {

    var instaOAuthPageURL: Observable<UserPageEntity?> = Observable(nil)

    let myPageUsecase: ViewMyPageUsecase = ViewDefaultMyPageUsecase()

    func enquireAllData() {
        myPageUsecase.executeUserPage { [weak self] userPage in
            self?.enquireImages(with: userPage)
        }
    }
}

private extension HomeViewModel {

    func enquireImages(with entity: UserPageEntity) {
        entity.media.images.forEach {
            myPageUsecase.executeMediaImage(with: $0.id)
        }
        
    }
}
