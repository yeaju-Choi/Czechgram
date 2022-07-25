//
//  ViewDefaultDetailPostRepository.swift
//  Czechgram
//
//  Created by juntaek.oh on 2022/07/25.
//

import UIKit

final class ViewDefaultDetailPostRepository: ViewDetailPostRepository {

    let networkService: NetworkServiceable = NetworkService()

    func requestChildrenData(with id: String, for completion: @escaping (MediaDTO) -> Void) {
        guard let token = UserDefaults.standard.object(forKey: "accessToken") as? String else { return }
        networkService.request(endPoint: .detailPage(mediaID: id, token: token)) { result in
            switch result {
            case .success(let data):
                let jsonConverter = JSONConverter<MediaDTO>()
                guard let mediaDTO = jsonConverter.decode(data: data) else { print(NetworkError.noURL)
                    return }

                completion(mediaDTO)
            case .failure:
                print(NetworkError.noData)
            }
        }
    }

    func requestChildrenImage(with id: String, for completion: @escaping (UIImage?, String?) -> Void) {
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
}

private extension ViewDefaultDetailPostRepository {

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
}
