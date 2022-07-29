//
//  LoginViewModel.swift
//  Czechgram
//
//  Created by juntaek.oh on 2022/07/12.
//

import Foundation
import RxSwift
import RxRelay

final class LoginViewModel {

    private let instagramUsecase: OAuthLoginUsecase = InstagramLoginUsecase()

    let disposeBag = DisposeBag()
    let instaOAuthPageURL = PublishRelay<URL>()
    let isFetchedOAuthToken = PublishRelay<Bool>()

    init() {
        configureNotification()
        configureBinding()
    }

    func enquireInstaToken() {
        guard let url = instagramUsecase.execute() else {
            isFetchedOAuthToken.accept(false)
            return
        }
        
        instaOAuthPageURL.accept(url)
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
        
        instagramUsecase.execute(with: code)
    }
    
    func configureBinding() {
        instagramUsecase.longLivedToken
            .subscribe(onNext: { [weak self] token in
                self?.isFetchedOAuthToken.accept(true)
                
            }, onError: { error in
                self.isFetchedOAuthToken.accept(false)
                
            })
            .disposed(by: disposeBag)
    }
}
