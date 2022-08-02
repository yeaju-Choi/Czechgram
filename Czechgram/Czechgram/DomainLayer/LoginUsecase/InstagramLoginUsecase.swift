//
//  InstagramLoginUsecase.swift
//  Czechgram
//
//  Created by juntaek.oh on 2022/07/19.
//

import Foundation
import RxSwift

final class InstagramLoginUsecase: OAuthLoginUsecase {

    let networkService: NetworkServiceable = NetworkService()

    let disposeBag = DisposeBag()

    let validURL = PublishSubject<URL>()
    let longLivedToken = PublishSubject<String>()

    func execute() {
        guard let url = EndPoint.instagramAuthorize.url else { return }
        validURL.onNext(url)
    }

    func execute(with grantCode: String) {
        changeShortLivedToken(from: grantCode)
    }
}

private extension InstagramLoginUsecase {

    func changeShortLivedToken(from grantCode: String) {
        networkService.request(endPoint: .shortLivedToken(code: grantCode))
            .subscribe { [weak self] data in
                guard let jsonData = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
                      let accessToken = jsonData["access_token"] as? String,
                      let userID = jsonData["user_id"] as? UInt else { return }

                UserDefaults.standard.set(userID, forKey: "userID")
                self?.changeLongLivedToken(from: accessToken)

            } onFailure: { error in
                print(error.localizedDescription)

            }
            .disposed(by: disposeBag)
    }

    func changeLongLivedToken(from shortToken: String) {
        networkService.request(endPoint: .longLivedToken(token: shortToken))
            .subscribe { [weak self] data in
                guard let jsonData = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
                let accessToken = jsonData["access_token"] as? String else { return }

                UserDefaults.standard.set(accessToken, forKey: "accessToken")
                self?.longLivedToken.onNext(accessToken)

            } onFailure: { error in
                print(error.localizedDescription)

            }
            .disposed(by: disposeBag)
    }
}
