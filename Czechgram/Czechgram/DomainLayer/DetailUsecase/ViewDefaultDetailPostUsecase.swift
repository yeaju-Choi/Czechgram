//
//  ViewDefaultDetailPostUsecase.swift
//  Czechgram
//
//  Created by juntaek.oh on 2022/07/25.
//

import Foundation

final class ViewDefaultDetailPostUsecase: ViewDetailPostUsecase {

    private var detailPostRepository: ViewDetailPostRepository = ViewDefaultDetailPostRepository()

    func executePostData(with id: String, completion: @escaping ([MediaImageEntity]) -> Void) {
        detailPostRepository.requestChildrenData(with: id) { mediaDTO in
            var mediaImageEnities = [MediaImageEntity]()

            mediaDTO.mediaIDs.forEach {
                let entity = MediaImageEntity(id: $0.id)
                mediaImageEnities.append(entity)
            }

            completion(mediaImageEnities)
        }
    }

    func executePostImages(with imageEntity: MediaImageEntity, completion: @escaping (MediaImageEntity) -> Void) {
        detailPostRepository.requestChildrenImage(with: imageEntity.id) { [weak self] image, createdTime in
            guard let image = image, let time = createdTime, let date = self?.convertDate(with: time) else { return }
            var entity = imageEntity
            entity.image = image
            entity.createdTime = date
            // TODO: entity 저장 (캐시, 파일매니저)
            completion(entity)
        }
    }
}

private extension ViewDefaultDetailPostUsecase {

    func convert(from userDTO: MediaDTO) -> MediaEntity {
        let userEntity = MediaEntity(images: [MediaImageEntity](), page: userDTO.paging)
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