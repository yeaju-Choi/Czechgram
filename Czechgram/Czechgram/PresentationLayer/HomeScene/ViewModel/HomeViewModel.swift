//
//  HomeViewModel.swift
//  Czechgram
//
//  Created by juntaek.oh on 2022/07/20.
//

import Foundation

final class HomeViewModel {

    var myPageData: Observable<UserPageEntity?> = Observable(nil)

    let myPageUsecase: ViewMyPageUsecase = ViewDefaultMyPageUsecase()

    func enquireAllData() {
        myPageUsecase.executeUserPage { [weak self] userPage in
            self?.enquireImages(with: userPage, completion: { [weak self] mediaImages in
                var completedUserPage = userPage
                completedUserPage.media.images = mediaImages
                self?.myPageData.updateValue(value: completedUserPage)
            })
        }
    }
}

private extension HomeViewModel {

    func enquireImages(with entity: UserPageEntity, completion : @escaping ([MediaImageEntity]) -> Void) {
        var imageEntites = [MediaImageEntity]()
        entity.media.images.forEach {
            myPageUsecase.executeMediaImage(with: $0) { mediaEntity in
                imageEntites.append(mediaEntity)
            }
        }

    }
}
