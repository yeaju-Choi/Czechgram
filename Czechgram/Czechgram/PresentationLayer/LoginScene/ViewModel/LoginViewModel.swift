//
//  LoginViewModel.swift
//  Czechgram
//
//  Created by juntaek.oh on 2022/07/12.
//

import UIKit

final class LoginViewModel {

    var instaOAuthPageURL: Observable<URL?> = Observable(nil)
    var isFetchedOAuthToken: Observable<Bool> = Observable(false)

    private var shortLivedToken: String = "" {
        didSet {
            self.fetchLongLivedToken()
        }
    }

    init() {
        configureNotification()
    }

    func enquireInstaToken() {
        // TODO: usecase.execute()로 변경 예정
        updateInstaPageURL()
    }
}

// MARK: Private extension of Settings

private extension LoginViewModel {

    func configureNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(fetchGrantCode(_:)), name: NSNotification.Name("GrantCode"), object: nil)
    }

    @objc
    func fetchGrantCode(_ notification: Notification) {
        guard let code = notification.userInfo?["GrantCode"] as? String else { return }
        fetchShortLivedToken(grantCode: code)
    }
}

// MARK: Private extension of Internal Call

private extension LoginViewModel {

    func updateInstaPageURL() {
        instaOAuthPageURL.updateValue(value: EndPoint.instagramAuthorize.url)
    }

    func fetchShortLivedToken(grantCode: String) {
        NetworkService.request(endPoint: .shortLivedToken(code: grantCode)) { [weak self] result in
            switch result {
            case .success(let data):
                      guard let jsonData = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
                      let accessToken = jsonData["access_token"] as? String,
                      let userID = jsonData["user_id"] as? UInt else { return }
                UserDefaults.standard.set(userID, forKey: "userID")
                self?.shortLivedToken = accessToken

            case .failure(let error):
                print(error.localizedDescription)
                self?.isFetchedOAuthToken.updateValue(value: false)
            }
        }
    }

    func fetchLongLivedToken() {
        NetworkService.request(endPoint: .longLivedToken(token: shortLivedToken)) { [weak self] result in
            switch result {
            case .success(let data):
                guard let jsonData = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
                let accessToken = jsonData["access_token"] as? String else { return }

                UserDefaults.standard.set(accessToken, forKey: "accessToken")
                self?.isFetchedOAuthToken.updateValue(value: true)

            case .failure(let error):
                print(error.localizedDescription)
                self?.isFetchedOAuthToken.updateValue(value: false)
            }
        }
    }
}
