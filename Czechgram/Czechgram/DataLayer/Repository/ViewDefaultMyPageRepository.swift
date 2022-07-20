//
//  ViewDefaultMyPageRepository.swift
//  Czechgram
//
//  Created by juntaek.oh on 2022/07/20.
//

import Foundation

final class ViewDefaultMyPageRepository: ViewMyPageRepository {

    let networkService: NetworkServiceable = NetworkService()

    func requestPageData(for completion: @escaping (UserPageDTO?) -> Void) {
        fetchUserPageData(with: completion)
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
}
