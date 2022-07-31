//
//  ViewMyPageUsecase.swift
//  Czechgram
//
//  Created by juntaek.oh on 2022/07/20.
//

import Foundation
import RxSwift

protocol ViewMainPageUsecase {

    var userPageEntity: PublishSubject<UserPageEntity> { get }

    func executeUserPage()
    func executeNextMediaImage()

}
