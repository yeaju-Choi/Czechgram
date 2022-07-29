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

//    let disposeBag = DisposeBag()
    
    struct Input {
        let loginButtonDidTapEvent: Observable<Void>
    }
    
    struct Output {
        let instaOAuthPageURL = PublishRelay<URL>()
        let isFetchedOAuthToken = PublishRelay<Bool>()
    }

    init() {
        configureNotification()
//        configureBinding()
    }
    
    func transform(input: Input, disposeBag: DisposeBag) -> Output {
        let output = Output()
        
        input.loginButtonDidTapEvent
            .subscribe({ [weak self] _ in
                self?.instagramUsecase.execute()
            })
            .disposed(by: disposeBag)
        
        self.instagramUsecase.validURL
            .bind(to: output.instaOAuthPageURL)
            .disposed(by: disposeBag)
        
        self.instagramUsecase.longLivedToken
            .map { !$0.isEmpty }
            .bind(to: output.isFetchedOAuthToken)
            .disposed(by: disposeBag)
        
        return output
    }

//    func enquireInstaToken() {
//        guard let url = instagramUsecase.execute() else {
//            isFetchedOAuthToken.accept(false)
//            return
//        }
//
//        instaOAuthPageURL.accept(url)
//    }
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
    
//    func configureBinding() {
//        instagramUsecase.longLivedToken
//            .subscribe(onNext: { [weak self] token in
//                self?.isFetchedOAuthToken.accept(true)
//
//            }, onError: { error in
//                self.isFetchedOAuthToken.accept(false)
//
//            })
//            .disposed(by: disposeBag)
//    }
}
