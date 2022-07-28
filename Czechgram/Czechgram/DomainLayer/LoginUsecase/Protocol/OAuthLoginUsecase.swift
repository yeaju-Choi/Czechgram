//
//  OAuthLoginUsecase.swift
//  Czechgram
//
//  Created by juntaek.oh on 2022/07/19.
//

import Foundation
import RxSwift

protocol OAuthLoginUsecase {

    var longLivedToken: PublishSubject<String> { get }
    
    func execute() -> URL?
    func execute(with grantCode: String)
}
