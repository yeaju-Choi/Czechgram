//
//  OAuthLoginUsecase.swift
//  Czechgram
//
//  Created by juntaek.oh on 2022/07/19.
//

import Foundation
import RxSwift

protocol OAuthLoginUsecase {

    func execute() -> URL?
    func execute(with grantCode: String) -> Observable<String>
    
//    func execute(_ urlCompletion: @escaping (URL) -> Void)
//    func execute(with grantCode: String, _ tokenCompletion: @escaping (String?) -> Void)
}
