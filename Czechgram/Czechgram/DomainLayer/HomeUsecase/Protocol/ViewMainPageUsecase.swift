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
    var userImageEntity: PublishSubject<MediaImageEntity> { get }
    var mediaEntity: PublishSubject<MediaEntity> { get }
    
    func executeUserPage()
    func executeMediaImage(with imageEntity: MediaImageEntity)
    func executeNextMediaImage(with nextImageSection: String?)
    
}
