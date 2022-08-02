//
//  ViewDefaultDetailPostUsecase.swift
//  Czechgram
//
//  Created by juntaek.oh on 2022/07/25.
//

import Foundation
import RxSwift

final class ViewDefaultDetailPageUsecase: ViewDetailPageUsecase {

    private var detailPostRepository: ViewDetailPageRepository = ViewDefaultDetailPageRepository()
    let mediaImageEntitesSubject = PublishSubject<[MediaImageEntity]>()
    let mediaImageEntitySubject = PublishSubject<MediaImageEntity>()

    let disposebag = DisposeBag()

    func executePostData(with id: String) {
        detailPostRepository.requestChildrenData(with: id)
            .subscribe { [weak self] mediaDTO in
                var mediaImageEnities = [MediaImageEntity]()

                if !mediaDTO.mediaIDs.isEmpty {
                    mediaDTO.mediaIDs.forEach {
                        let entity = MediaImageEntity(id: $0.id)
                        mediaImageEnities.append(entity)
                    }
                }
                self?.mediaImageEntitesSubject.onNext(mediaImageEnities)

            } onError: { error in
                print(error.localizedDescription)
            }.disposed(by: disposebag)
    }

    func executePostImages(with imageEntity: MediaImageEntity) {

        detailPostRepository.requestChildrenImage(with: imageEntity.id)
            .subscribe { [weak self] image, createdTime in
                guard let date = self?.convertDate(with: createdTime) else { return }
                var entity = imageEntity
                entity.image = image
                entity.createdTime = date
                self?.mediaImageEntitySubject.onNext(entity)
            } onError: { error in
                print(error.localizedDescription)
            }.disposed(by: disposebag)
    }
}

private extension ViewDefaultDetailPageUsecase {

    func convert(from userDTO: MediaDTO) -> MediaEntity {
        let userEntity = MediaEntity(images: [MediaImageEntity](), page: userDTO.paging ?? MediaPagingDTO(next: nil, previous: nil))
        return userEntity
    }

    func convertDate(with: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss+SSSS"
        dateFormatter.timeZone = TimeZone(identifier: "UTC")
        if let date = dateFormatter.date(from: with) {
            return date
        } else {
            return nil
        }
    }
}
