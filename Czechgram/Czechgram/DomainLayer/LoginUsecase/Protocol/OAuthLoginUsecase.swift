//
//  OAuthLoginUsecase.swift
//  Czechgram
//
//  Created by juntaek.oh on 2022/07/19.
//

import Foundation
import RxSwift

protocol OAuthLoginUsecase {

    var validURL: PublishSubject<URL> { get }
    var longLivedToken: PublishSubject<String> { get }

    func execute()
    func execute(with grantCode: String)
}
