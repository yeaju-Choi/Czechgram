//
//  ViewDefaultMyPageUsecase.swift
//  Czechgram
//
//  Created by juntaek.oh on 2022/07/20.
//

import Foundation

final class ViewDefaultMyPageUsecase: ViewMyPageUsecase {

    let myPageRepository: ViewMyPageRepository = ViewDefaultMyPageRepository()

    func executeUserPage(completion: @escaping (UserPageEntity) -> Void) {
        myPageRepository.requestPageData { [weak self] userPageDTO in
            guard let validDTO = userPageDTO, let entity = self?.convertEntity(from: validDTO) else { return }

            completion(entity)
        }
    }

    func executeMediaImage(with imageEntity: MediaImageEntity, completion: @escaping (MediaImageEntity) -> Void) {
        myPageRepository.requestMediaData(with: imageEntity.id) { [weak self] image, createdTime in
            guard let image = image, let time = createdTime, let date = self?.convertDate(with: time) else { return }
            var entity = imageEntity
            entity.image = image
            entity.createdTime = date
            completion(entity)
        }
    }

}

private extension ViewDefaultMyPageUsecase {

    func convertEntity(from userDTO: UserPageDTO) -> UserPageEntity {
        var imageEntity = [MediaImageEntity]()
        userDTO.media.mediaIDs.forEach {
            let entity = MediaImageEntity(id: $0.id)
            imageEntity.append(entity)
        }
        let mediaEntity = MediaEntity(images: imageEntity, page: userDTO.media.paging)
        let userEntity = UserPageEntity(userName: userDTO.username, mediaCount: userDTO.mediaCount, media: mediaEntity)
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
