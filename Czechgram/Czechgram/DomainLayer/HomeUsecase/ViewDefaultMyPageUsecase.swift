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
        myPageRepository.requestMediaData(with: imageEntity.id) { image in
            guard let image = image else { return }
            var entity = imageEntity
            entity.image = image
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

        imageEntity.sort { lhs, rhs in
            lhs.id > rhs.id
        }
        let mediaEntity = MediaEntity(images: imageEntity, page: userDTO.media.paging)
        let userEntity = UserPageEntity(userName: userDTO.username, mediaCount: userDTO.mediaCount, media: mediaEntity)
        return userEntity
    }
}
