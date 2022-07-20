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
                let images = mediaImages.sorted { firstValue, secondValue in
                    if let firstTime = firstValue.createdTime, let secondTime = secondValue.createdTime {
                        return firstTime > secondTime
                    } else {
                        return firstValue.id > secondValue.id
                    }
                }

                var completedUserPage = userPage
                completedUserPage.media.images = images
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

                guard imageEntites.count != entity.media.images.count else {
                    completion(imageEntites)
                    return
                }
            }
        }
    }
}
