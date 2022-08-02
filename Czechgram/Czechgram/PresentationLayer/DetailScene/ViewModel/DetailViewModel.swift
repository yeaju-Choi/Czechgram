//
//  DetailViewModel.swift
//  Czechgram
//
//  Created by juntaek.oh on 2022/07/25.
//

import Foundation
import RxSwift
import RxRelay

final class DetailViewModel {

    let mediaImageEntity: MediaImageEntity
    var mediaCount = 0

    private var detailUsecase: ViewDetailPageUsecase = ViewDefaultDetailPageUsecase()
    private var tempImageEntites = [MediaImageEntity]()

    struct Output {
        let myPageData = PublishRelay<[MediaImageEntity]>()
    }

    func transform(disposeBag: DisposeBag) -> Output {
        let output = Output()

        detailUsecase.mediaImageEntitesSubject
            .bind { [weak self] mediaImages in
                guard let imageEntity = self?.mediaImageEntity else { return }
                if mediaImages.isEmpty {
                    output.myPageData.accept([imageEntity])

                } else {
                    self?.supplementProperties(for: mediaImages)
                }
            }.disposed(by: disposeBag)

        detailUsecase.mediaImageEntitySubject
            .bind { [weak self] mediaImageEntity in
                guard let self = self else { return }
                self.tempImageEntites.append(mediaImageEntity)
                guard self.tempImageEntites.count != self.mediaCount else {
                    output.myPageData.accept(self.tempImageEntites)
                    return
                }
            }.disposed(by: disposeBag)

        return output
    }

    init(cellEntity: MediaImageEntity) {
        self.mediaImageEntity = cellEntity
    }

    func enquireImages() {
        detailUsecase.executePostData(with: mediaImageEntity.id)
    }
}

private extension DetailViewModel {

    func supplementProperties(for mediaImage: [MediaImageEntity]) {
        mediaCount = mediaImage.count
        mediaImage.forEach {
            detailUsecase.executePostImages(with: $0)
        }
    }
}

