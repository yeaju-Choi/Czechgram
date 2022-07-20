//
//  ViewDefaultMyPageRepository.swift
//  Czechgram
//
//  Created by juntaek.oh on 2022/07/20.
//

import UIKit

final class ViewDefaultMyPageRepository: ViewMyPageRepository {

    let networkService: NetworkServiceable = NetworkService()

    func requestPageData(for completion: @escaping (UserPageDTO?) -> Void) {
        fetchUserPageData(with: completion)
    }

    func requestMediaData(with id: String, for completion: @escaping (UIImage?) -> Void) {
        guard let token = UserDefaults.standard.object(forKey: "accessToken") as? String else { return }
        networkService.request(endPoint: .imageUrl(mediaID: id, token: token)) { [weak self] result in
            switch result {
            case .success(let data):
                let jsonConverter = JSONConverter<MediaUrlDTO>()
                let mediaUrlDTO = jsonConverter.decode(data: data)
                guard let url: String = mediaUrlDTO?.mediaType == .Video ? mediaUrlDTO?.thumbnailUrl : mediaUrlDTO?.mediaUrl else { print(NetworkError.noURL)
                    return }

                self?.fetchUserImageData(with: url, completion: completion)
            case .failure:
                print(NetworkError.noData)
            }
        }

    }

}

private extension ViewDefaultMyPageRepository {

    func fetchUserPageData(with completion: @escaping (UserPageDTO?) -> Void) {
        guard let token = UserDefaults.standard.object(forKey: "accessToken") as? String else { return }

        networkService.request(endPoint: EndPoint.userPage(token: token)) { result in
            switch result {
            case .success(let data):
                let jsonConveter = JSONConverter<UserPageDTO>()
                let userData: UserPageDTO? = jsonConveter.decode(data: data)
                completion(userData)

            case .failure:
                print(NetworkError.noData)
            }
        }
    }

    func fetchUserImageData(with url: String, completion: @escaping (UIImage?) -> Void) {
        guard let url = URL(string: url) else { return }
        networkService.requestImage(url: url) { result in
            switch result {
            case .success(let data):
                let image = UIImage(data: data)
                completion(image)
            case .failure:
                print(NetworkError.noData)

            }
        }
    }
}
