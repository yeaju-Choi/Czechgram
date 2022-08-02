//
//  ViewDefaultMyPageRepository.swift
//  Czechgram
//
//  Created by juntaek.oh on 2022/07/20.
//

import UIKit
import RxSwift

final class ViewDefaultMainPageRepository: ViewMainPageRepository {

    let networkService: NetworkServiceable = NetworkService()

    let userDTO = PublishSubject<UserPageDTO>()
    let mediaDTO = PublishSubject<MediaDTO>()
    let imageData = PublishSubject<(String, UIImage, String)>()

    let disposBage = DisposeBag()

    func requestPageData() {
        guard let token = UserDefaults.standard.object(forKey: "accessToken") as? String else { return }

        networkService.request(endPoint: EndPoint.userPage(token: token))
           .subscribe(onSuccess: { [weak self] data in
               let jsonConveter = JSONConverter<UserPageDTO>()
               guard let userPageDTO = jsonConveter.decode(data: data) else { return }
               self?.userDTO.onNext(userPageDTO)

           }, onFailure: { error in
               print(error.localizedDescription)

           })
           .disposed(by: disposBage)
    }

    func requestMediaData(with id: String) {
        guard let token = UserDefaults.standard.object(forKey: "accessToken") as? String else { return }

            self.networkService.request(endPoint: .imageUrl(mediaID: id, token: token))
                .subscribe { [weak self] data in
                    let jsonConverter = JSONConverter<MediaUrlDTO>()
                    guard let mediaUrlDTO = jsonConverter.decode(data: data) else { return }
                    self?.fetchUserImageData(with: mediaUrlDTO)
                    
                } onFailure: { error in
                    print(error)

                }
                .disposed(by: disposBage)
    }

    func requestNextPageMediaData(with validURL: URL) {
        networkService.requestImage(url: validURL)
            .subscribe { [weak self] data in
                let jsonConverter = JSONConverter<MediaDTO>()
                guard let mediaDTO = jsonConverter.decode(data: data) else { return }
                self?.mediaDTO.onNext(mediaDTO)

            } onFailure: { [weak self] error in
                self?.mediaDTO.onError(error)

            }
            .disposed(by: disposBage)
    }
}

private extension ViewDefaultMainPageRepository {

    func fetchUserImageData(with dto: MediaUrlDTO) {
        guard let url: String = dto.mediaType == .Video ? dto.thumbnailUrl : dto.mediaUrl, let validUrl = URL(string: url) else { return }

        if let cachedImage = ImageCacheService.loadData(url: validUrl) {
            imageData.onNext((dto.id, cachedImage, dto.timestamp))
        } else {
            networkService.requestImage(url: validUrl)
                .subscribe(onSuccess: { [weak self] data in
                    guard let image = UIImage(data: data) else { return }
                    ImageCacheService.saveData(image: image, url: validUrl)
                    self?.imageData.onNext((dto.id, image, dto.timestamp))

                }, onFailure: { [weak self] _ in
                    self?.imageData.onError(NetworkError.noData)

                })
                .disposed(by: disposBage)
        }
    }
}
