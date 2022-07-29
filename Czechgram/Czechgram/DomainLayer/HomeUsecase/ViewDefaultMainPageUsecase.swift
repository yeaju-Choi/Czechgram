//
//  ViewDefaultMyPageUsecase.swift
//  Czechgram
//
//  Created by juntaek.oh on 2022/07/20.
//

import Foundation
import RxSwift

final class ViewDefaultMainPageUsecase: ViewMainPageUsecase {

    let myPageRepository: ViewMainPageRepository = ViewDefaultMainPageRepository()
    let userPageEntity = PublishSubject<UserPageEntity>()
    let disposeBag = DisposeBag()

    
    func executeUserPage() {
        myPageRepository.requestPageData()
            .map { self.convert(from: $0) }
            .subscribe { [weak self] userpageEntity in
                self?.userPageEntity.onNext(userpageEntity)
            } onError: { error in
                print(error.localizedDescription)
            }
            .disposed(by: disposeBag)

    
    }
    
//    func executeUserPage(completion: @escaping (UserPageEntity) -> Void) {
//        myPageRepository.requestPageData { [weak self] userPageDTO in
//            guard let validDTO = userPageDTO, let entity = self?.convert(from: validDTO) else { return }
//
//            completion(entity)
//        }
//    }

    func executeMediaImage(with imageEntity: MediaImageEntity, completion: @escaping (MediaImageEntity) -> Void) {
        myPageRepository.requestMediaData(with: imageEntity.id) { [weak self] image, createdTime in
            guard let image = image, let time = createdTime, let date = self?.convertDate(with: time) else { return }
            var entity = imageEntity
            entity.image = image
            entity.createdTime = date
            // TODO: entity 저장 (캐시, 파일매니저)
            completion(entity)
        }
    }

    func executeNextMediaImage(with nextImageSection: String?, completion: @escaping (MediaEntity?) -> Void) {
        guard let section = nextImageSection, let url = URL(string: section) else { return }
        myPageRepository.requestNextPageMediaData(with: url) { [weak self] media in
            guard let media = media else { return }
            let mediaEntity = self?.convert(from: media)
            completion(mediaEntity)
        }
    }
}

private extension ViewDefaultMainPageUsecase {

    func convert(from mediaDTO: MediaDTO) -> MediaEntity {
        var imageEntity = [MediaImageEntity]()
        mediaDTO.mediaIDs.forEach {
            let entity = MediaImageEntity(id: $0.id)
            imageEntity.append(entity)
        }
        let mediaEntity = MediaEntity(images: imageEntity, page: mediaDTO.paging ?? MediaPagingDTO(next: nil, previous: nil))

        return mediaEntity
    }

    func convert(from userDTO: UserPageDTO) -> UserPageEntity {
        let mediaEntity = self.convert(from: userDTO.media)
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
