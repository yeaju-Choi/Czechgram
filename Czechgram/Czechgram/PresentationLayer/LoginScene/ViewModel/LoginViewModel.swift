//
//  LoginViewModel.swift
//  Czechgram
//
//  Created by juntaek.oh on 2022/07/12.
//

import UIKit

final class LoginViewModel {

    var instaOAuthPageURL: Observable<URL?> = Observable(nil)

    private var shortLivedToken: String = "" {
        didSet {
            self.fetchLongLivedToken()
        }
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
            }
        }
    }

    func fetchLongLivedToken() {
        NetworkService.request(endPoint: .longLivedToken(token: shortLivedToken)) { result in
            switch result {
            case .success(let data):
                guard let jsonData = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
                let accessToken = jsonData["access_token"] as? String else { return }
                UserDefaults.standard.set(accessToken, forKey: "accessToken")
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
