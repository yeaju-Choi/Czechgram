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

    private var tempUserPageEntity: UserPageEntity?
    private var tempImageData = [MediaImageEntity]() {
        didSet {
            guard let entity = tempUserPageEntity, entity.media.images.count == tempImageData.count else { return }

            var extraEntity = entity
            extraEntity.media.images = tempImageData
            tempUserPageEntity?.media.images = tempImageData

            userPageEntity.onNext(extraEntity)
        }
    }

    init() {
        myPageRepository.userDTO
            .map { self.convert(from: $0) }
            .subscribe { [weak self] userPageEntity in
                self?.tempUserPageEntity = userPageEntity
                self?.setMediaImage(with: userPageEntity.media)
            } onError: { error in
                print(error.localizedDescription)
            }
            .disposed(by: disposeBag)

        myPageRepository.mediaDTO
            .map { self.convert(from: $0)}
            .subscribe { [weak self] mediaEntity in
                self?.tempUserPageEntity?.media.images.append(contentsOf: mediaEntity.images)
                self?.setMediaImage(with: mediaEntity)
            } onError: { error in
                print(error.localizedDescription)
            }.disposed(by: disposeBag)

        myPageRepository.imageData
            .subscribe { [weak self] imageData in
                let date = self?.convertDate(with: imageData.2)
                let entity = MediaImageEntity(id: imageData.0, image: imageData.1, createdTime: date)
                self?.tempImageData.append(entity)

            } onError: { error in
                print(error.localizedDescription)
            }
            .disposed(by: disposeBag)
    }

    func executeUserPage() {
        myPageRepository.requestPageData()
    }

    func executeNextMediaImage() {
        guard let section = tempUserPageEntity?.media.page.next, let url = URL(string: section) else { return }

        myPageRepository.requestNextPageMediaData(with: url)
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

    func setMediaImage(with id: MediaEntity) {
        id.images.forEach {
            myPageRepository.requestMediaData(with: $0.id)
        }
    }
}
