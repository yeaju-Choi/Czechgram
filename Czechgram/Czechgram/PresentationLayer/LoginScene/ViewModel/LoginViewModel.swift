//
//  LoginViewModel.swift
//  Czechgram
//
//  Created by juntaek.oh on 2022/07/12.
//

import Foundation

final class LoginViewModel {

    private let instagramUsecase: OAuthLoginUsecase = InstagramLoginUsecase()

    var instaOAuthPageURL: Observable<URL?> = Observable(nil)
    var isFetchedOAuthToken: Observable<Bool> = Observable(false)

    init() {
        configureNotification()
    }

    func enquireInstaToken() {
        instagramUsecase.execute { [weak self] validURL in
            self?.instaOAuthPageURL.updateValue(value: validURL)
        }
    }
}

// MARK: Private extension of Settings

private extension LoginViewModel {

    func configureNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(transferGrantCode(_:)), name: NSNotification.Name("GrantCode"), object: nil)
    }

    @objc
    func transferGrantCode(_ notification: Notification) {
        guard let code = notification.userInfo?["GrantCode"] as? String else { return }
        instagramUsecase.execute(with: code) { [weak self] token in
            guard let longLivedToken = token else {
                self?.isFetchedOAuthToken.updateValue(value: false)
                return
            }

            UserDefaults.standard.set(longLivedToken, forKey: "accessToken")
            self?.isFetchedOAuthToken.updateValue(value: true)
        }
    }
}
