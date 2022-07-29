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

    
    func executeUserPage() {
        myPageRepository.requestPageData()
            .map { self.convert(from: $0) }
            .subscribe { [weak self] userPageEntity in
                self?.tempUserPageEntity = userPageEntity
                self?.setMediaImage(with: userPageEntity.media)
            } onError: { error in
                print(error.localizedDescription)
            }
            .disposed(by: disposeBag)

    
    }

    func executeNextMediaImage() {
        guard let section = tempUserPageEntity?.media.page.next, let url = URL(string: section) else { return }
        myPageRepository.requestNextPageMediaData(with: url)
            .map{ self.convert(from: $0)}
            .subscribe { [weak self] mediaEntity in
                self?.appendMediaImages(with: mediaEntity)
            } onError: { error in
                print(error.localizedDescription)
            }.disposed(by: disposeBag)
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
    
    func appendMediaImages(with mediaEntity: MediaEntity) {
        var box = [MediaImageEntity]()
        Observable.from(mediaEntity.images)
            .subscribe { [weak self] imageEntity in
                self?.myPageRepository.requestMediaData(with: imageEntity.id)
                    .map{ ($0.0, self?.convertDate(with: $0.1)) }
                    .subscribe { (image,date) in
                        var entity = imageEntity
                        entity.image = image
                        entity.createdTime = date
                        box.append(entity)
                    } onError: { error in
                        print(error.localizedDescription)
                    }.dispose()
            } onError: { error in
                print(error.localizedDescription)
            } onCompleted: {
                guard let tempUserPageEntity = self.tempUserPageEntity else {
                    return
                }
                var newValue = tempUserPageEntity
                newValue.media.images.append(contentsOf: box)
                self.userPageEntity.onNext(newValue)
            }.disposed(by: disposeBag)

    }
    
    func setMediaImage(with mediaEntity: MediaEntity) {
        
        var box = [MediaImageEntity]()
        Observable.from(mediaEntity.images)
            .subscribe { [weak self] imageEntity in
                self?.myPageRepository.requestMediaData(with: imageEntity.id)
                    .map{ ($0.0, self?.convertDate(with: $0.1)) }
                    .subscribe { (image,date) in
                        var entity = imageEntity
                        entity.image = image
                        entity.createdTime = date
                        box.append(entity)
                    } onError: { error in
                        print(error.localizedDescription)
                    }.dispose()
            } onError: { error in
                print(error.localizedDescription)
            } onCompleted: {
                guard let tempUserPageEntity = self.tempUserPageEntity else {
                    return
                }
                var newValue = tempUserPageEntity
                newValue.media.images = box
                self.userPageEntity.onNext(newValue)
            }.disposed(by: disposeBag)

    }
}
