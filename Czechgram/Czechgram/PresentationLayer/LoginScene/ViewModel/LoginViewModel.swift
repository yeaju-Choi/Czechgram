//
//  LoginViewModel.swift
//  Czechgram
//
//  Created by juntaek.oh on 2022/07/12.
//

import UIKit

final class LoginViewModel {

    var instaOAuthPageURL: Observable<URL?> = Observable(nil)

    func enquireInstaToken() {
        // TODO: usecase.execute()로 변경 예정
        updateInstaPageURL()
    }
}

private extension LoginViewModel {

    func updateInstaPageURL() {
        instaOAuthPageURL.updateValue(value: EndPoint.instagramAuthorize.url)
    }
}
