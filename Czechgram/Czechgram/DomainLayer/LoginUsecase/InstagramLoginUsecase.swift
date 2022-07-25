//
//  InstagramLoginUsecase.swift
//  Czechgram
//
//  Created by juntaek.oh on 2022/07/19.
//

import Foundation

final class InstagramLoginUsecase: OAuthLoginUsecase {

    let networkService: NetworkServiceable = NetworkService()

    func execute(_ urlCompletion: @escaping (URL) -> Void) {
        guard let url = EndPoint.instagramAuthorize.url else { return }

        urlCompletion(url)
    }

    func execute(with grantCode: String, _ tokenCompletion: @escaping (String?) -> Void) {
        changeShortLivedToken(from: grantCode) { token in
            tokenCompletion(token)
        }
    }
}

private extension InstagramLoginUsecase {

    func changeShortLivedToken(from grantCode: String, _ tokenCompletion: @escaping (String?) -> Void) {
        networkService.request(endPoint: .shortLivedToken(code: grantCode)) { [weak self] result in
            switch result {
            case .success(let data):
                      guard let jsonData = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
                      let accessToken = jsonData["access_token"] as? String,
                      let userID = jsonData["user_id"] as? UInt else { return }

                UserDefaults.standard.set(userID, forKey: "userID")
                self?.changeLongLivedToken(from: accessToken) { token in
                    tokenCompletion(token)
                }

            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }

    func changeLongLivedToken(from shortToken: String, _ tokenCompletion: @escaping (String?) -> Void) {
        networkService.request(endPoint: .longLivedToken(token: shortToken)) { result in
            switch result {
            case .success(let data):
                guard let jsonData = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
                let accessToken = jsonData["access_token"] as? String else { return }

                UserDefaults.standard.set(accessToken, forKey: "accessToken")
                tokenCompletion(accessToken)

            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
