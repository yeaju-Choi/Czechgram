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
    
    func requestPageData() -> Observable<UserPageDTO> {
        
        return Observable<UserPageDTO>.create { [weak self] observable -> Disposable in
            if let token = UserDefaults.standard.object(forKey: "accessToken") as? String {
            self?.networkService.request(endPoint: EndPoint.userPage(token: token))
               .subscribe(onSuccess: { data in
                   let jsonConveter = JSONConverter<UserPageDTO>()
                   jsonConveter.decode(data: data)
                       .subscribe { userPageDTO in
                           observable.onNext(userPageDTO)
                       } onFailure: { error in
                           print(error.localizedDescription)
                       }.dispose()
                       
               }, onFailure: { error in
                   print(error.localizedDescription)
               }).dispose()
            } else {
                observable.onError(NetworkError.noData)
            }
            
            return Disposables.create()
        }
       
    }
    
    func requestMediaData(with id: String) {
        guard let token = UserDefaults.standard.object(forKey: "accessToken") as? String else { return }
        networkService.request(endPoint: .imageUrl(mediaID: id, token: token)) { [weak self] result in
            switch result {
            case .success(let data):
                let jsonConverter = JSONConverter<MediaUrlDTO>()
                guard let mediaUrlDTO = jsonConverter.decode(data: data) else { print(NetworkError.noURL)
                    return }

                self?.fetchUserImageData(with: mediaUrlDTO, completion: completion)
            case .failure:
                print(NetworkError.noData)
            }
        }
    }

    func requestNextPageMediaData(with validURL: URL, for completion: @escaping (MediaDTO?) -> Void) {
        networkService.requestImage(url: validURL) { result in
            switch result {
            case .success(let data):
                let jsonConverter = JSONConverter<MediaDTO>()
                let dto = jsonConverter.decode(data: data)
                completion(dto)

            case .failure:
                print(NetworkError.noData)
            }
        }
    }

//    func requestMediaData(with id: String, for completion: @escaping (UIImage?, String?) -> Void) {
//        guard let token = UserDefaults.standard.object(forKey: "accessToken") as? String else { return }
//        networkService.request(endPoint: .imageUrl(mediaID: id, token: token)) { [weak self] result in
//            switch result {
//            case .success(let data):
//                let jsonConverter = JSONConverter<MediaUrlDTO>()
//                guard let mediaUrlDTO = jsonConverter.decode(data: data) else { print(NetworkError.noURL)
//                    return }
//
//                self?.fetchUserImageData(with: mediaUrlDTO, completion: completion)
//            case .failure:
//                print(NetworkError.noData)
//            }
//        }
//    }
//
//    func requestNextPageMediaData(with validURL: URL, for completion: @escaping (MediaDTO?) -> Void) {
//        networkService.requestImage(url: validURL) { result in
//            switch result {
//            case .success(let data):
//                let jsonConverter = JSONConverter<MediaDTO>()
//                let dto = jsonConverter.decode(data: data)
//                completion(dto)
//
//            case .failure:
//                print(NetworkError.noData)
//            }
//        }
//    }

}

private extension ViewDefaultMainPageRepository {

    
    func fetchUserPageData() -> Observable<UserPageDTO>? {
        
        }
        
        
        
    }

    func fetchUserImageData(with dto: MediaUrlDTO, completion: @escaping (UIImage?, String?) -> Void) {
        guard let url: String = dto.mediaType == .Video ? dto.thumbnailUrl : dto.mediaUrl, let validUrl = URL(string: url) else { return }
        if let cachedImage = ImageCacheService.loadData(url: validUrl) {
            completion(cachedImage, dto.timestamp)
        } else {
            networkService.requestImage(url: validUrl) { result in
                switch result {
                case .success(let data):
                    let image = UIImage(data: data)
                    ImageCacheService.saveData(image: image, url: validUrl)
                    completion(image, dto.timestamp)
                case .failure:
                    print(NetworkError.noData)

                }
            }
        }
    }
//
//    func fetchUserPageData(with completion: @escaping (UserPageDTO?) -> Void) {
//        guard let token = UserDefaults.standard.object(forKey: "accessToken") as? String else { return }
//
//        networkService.request(endPoint: EndPoint.userPage(token: token)) { result in
//            switch result {
//            case .success(let data):
//                let jsonConveter = JSONConverter<UserPageDTO>()
//                let userData: UserPageDTO? = jsonConveter.decode(data: data)
//                completion(userData)
//
//            case .failure:
//                print(NetworkError.noData)
//            }
//        }
//    }
//
//    func fetchUserImageData(with dto: MediaUrlDTO, completion: @escaping (UIImage?, String?) -> Void) {
//        guard let url: String = dto.mediaType == .Video ? dto.thumbnailUrl : dto.mediaUrl, let validUrl = URL(string: url) else { return }
//        if let cachedImage = ImageCacheService.loadData(url: validUrl) {
//            completion(cachedImage, dto.timestamp)
//        } else {
//            networkService.requestImage(url: validUrl) { result in
//                switch result {
//                case .success(let data):
//                    let image = UIImage(data: data)
//                    ImageCacheService.saveData(image: image, url: validUrl)
//                    completion(image, dto.timestamp)
//                case .failure:
//                    print(NetworkError.noData)
//
//                }
//            }
//        }
//    }
}
