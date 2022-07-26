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
    var isLoading: Bool = false

    var isFetchAllData: Bool {
        return myPageData.value?.mediaCount == myPageData.value?.media.images.count
    }

    func enquireAllData() {
        isLoading = true
        myPageUsecase.executeUserPage { [weak self] userPage in
            self?.enquireImages(with: userPage.media, completion: { [weak self] mediaImages in
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

                DispatchQueue.global().async {
                    sleep(2)
                    self?.isLoading = false
                }

            })
        }
    }

    func enquireNextImages() {
        isLoading = true
        myPageUsecase.executeNextMediaImage(with: myPageData.value?.media.page.next) { [weak self] mediaEntity in
            guard let mediaEntity = mediaEntity else { return }
            self?.enquireImages(with: mediaEntity, completion: { [weak self] mediaImages in
                let images = mediaImages.sorted { firstValue, secondValue in
                    if let firstTime = firstValue.createdTime, let secondTime = secondValue.createdTime {
                        return firstTime > secondTime
                    } else {
                        return firstValue.id > secondValue.id
                    }
                }

                guard let userPage = self?.myPageData.value else { return }
                var refreshedUserPage = userPage
                refreshedUserPage.media.images.append(contentsOf: images)
                self?.myPageData.updateValue(value: refreshedUserPage)

                DispatchQueue.global().async {
                    sleep(2)
                    self?.isLoading = false
                }

            })
        }
    }
}

private extension HomeViewModel {

    func enquireImages(with entity: MediaEntity, completion : @escaping ([MediaImageEntity]) -> Void) {
        var imageEntites = [MediaImageEntity]()
        entity.images.forEach {
            myPageUsecase.executeMediaImage(with: $0) { mediaEntity in
                imageEntites.append(mediaEntity)

                guard imageEntites.count != entity.images.count else {
                    completion(imageEntites)
                    return
                }
            }
        }
    }

}
