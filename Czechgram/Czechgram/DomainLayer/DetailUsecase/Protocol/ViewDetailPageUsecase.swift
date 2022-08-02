//
//  ViewDetailPostUsecase.swift
//  Czechgram
//
//  Created by juntaek.oh on 2022/07/25.
//

import Foundation
import RxSwift

protocol ViewDetailPageUsecase {

    var mediaImageEntitesSubject: PublishSubject<[MediaImageEntity]> {get}
    var mediaImageEntitySubject: PublishSubject<MediaImageEntity> {get}

    func executePostData(with id: String)
    func executePostImages(with imageEntity: MediaImageEntity)
}
