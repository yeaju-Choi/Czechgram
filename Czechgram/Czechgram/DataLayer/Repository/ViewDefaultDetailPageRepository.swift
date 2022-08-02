//
//  ViewDefaultDetailPostRepository.swift
//  Czechgram
//
//  Created by juntaek.oh on 2022/07/25.
//

import UIKit
import RxSwift

final class ViewDefaultDetailPageRepository: ViewDetailPageRepository {

    let networkService: NetworkServiceable = NetworkService()
    let disposebag = DisposeBag()

    func requestChildrenData(with id: String) -> Observable<MediaDTO> {
        return Observable.create { [weak self] observer -> Disposable in
            guard let token = UserDefaults.standard.object(forKey: "accessToken") as? String, let self = self
            else { observer.onError(NetworkError.noData)
                return Disposables.create()
            }
            self.networkService.request(endPoint: .detailPage(mediaID: id, token: token))
                .subscribe { data in
                    let jsonConverter = JSONConverter<MediaDTO>()
                    guard let mediaDTO = jsonConverter.decode(data: data) else { return observer.onError(NetworkError.decodingError) }
                    observer.onNext(mediaDTO)
                } onFailure: { _ in
                    observer.onError(NetworkError.noData)
                }.disposed(by: self.disposebag)

            return Disposables.create()
        }
    }

    func requestChildrenImage(with id: String) -> Observable<(UIImage, String)> {
        return Observable.create { [weak self] observer -> Disposable in
            guard let token = UserDefaults.standard.object(forKey: "accessToken") as? String, let self = self
            else { observer.onError(NetworkError.noData)
                return Disposables.create()
                }
            self.networkService.request(endPoint: .imageUrl(mediaID: id, token: token))
                .subscribe { data in
                    let jsonConverter = JSONConverter<MediaUrlDTO>()
                    guard let mediaUrlDTO = jsonConverter.decode(data: data) else { return observer.onError(NetworkError.decodingError) }
                    self.fetchUserImageData(with: mediaUrlDTO)
                        .subscribe { imageSet in
                            observer.onNext(imageSet)
                        } onError: { _ in
                            observer.onError(NetworkError.noData)
                        }.disposed(by: self.disposebag)

                } onFailure: { _ in
                    observer.onError(NetworkError.noData)
                }.disposed(by: self.disposebag)
            return Disposables.create()
        }
    }
}

private extension ViewDefaultDetailPageRepository {

    func fetchUserImageData(with dto: MediaUrlDTO) -> Observable<(UIImage, String)> {
        return Observable.create { [weak self] observer -> Disposable in
            guard let url: String = dto.mediaType == .Video ? dto.thumbnailUrl : dto.mediaUrl, let validUrl = URL(string: url), let self = self
            else { observer.onError(NetworkError.noData)
                return Disposables.create()
            }
            if let cachedImage = ImageCacheService.loadData(url: validUrl) {
                observer.onNext((cachedImage, dto.timestamp))
            } else {
                self.networkService.requestImage(url: validUrl)
                    .subscribe { data in
                        guard let image = UIImage(data: data) else { return observer.onError(NetworkError.noData) }
                        ImageCacheService.saveData(image: image, url: validUrl)
                        observer.onNext((image, dto.timestamp))
                    } onFailure: { _ in
                        observer.onError(NetworkError.noData)
                    }.disposed(by: self.disposebag)
            }
            return Disposables.create()
        }
    }
}
