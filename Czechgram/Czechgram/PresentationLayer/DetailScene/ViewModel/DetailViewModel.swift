//
//  DetailViewModel.swift
//  Czechgram
//
//  Created by juntaek.oh on 2022/07/25.
//

import Foundation

final class DetailViewModel {

    var myPageData: Observable<[MediaImageEntity]?> = Observable(nil)

    let mediaImageEntity: MediaImageEntity
    private var detailUsecase: ViewDetailPageUsecase = ViewDefaultDetailPageUsecase()

    init(cellEntity: MediaImageEntity) {
        self.mediaImageEntity = cellEntity
    }

    func enquireImages() {
        detailUsecase.executePostData(with: mediaImageEntity.id) { [weak self] mediaImageEntities in
            guard let imageEntity = self?.mediaImageEntity else { return }

            if mediaImageEntities.isEmpty {
                self?.myPageData.updateValue(value: [imageEntity])

            } else {
                self?.supplementProperties(for: mediaImageEntities)
            }
        }
    }
}

private extension DetailViewModel {

    func supplementProperties(for mediaImage: [MediaImageEntity]) {
        var imageEntites = [MediaImageEntity]()

        mediaImage.forEach {
            detailUsecase.executePostImages(with: $0) { [weak self] imageEntity in
                imageEntites.append(imageEntity)

                guard imageEntites.count != mediaImage.count else {
                    imageEntites.sort { firstValue, secondValue in
                        if let firstTime = firstValue.createdTime, let secondTime = secondValue.createdTime {
                            return firstTime > secondTime
                        } else {
                            return firstValue.id > secondValue.id
                        }
                    }
                    self?.myPageData.updateValue(value: imageEntites)
                    return
                }
            }
        }
    }
}
