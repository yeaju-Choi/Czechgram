//
//  ViewMyPageRepository.swift
//  Czechgram
//
//  Created by juntaek.oh on 2022/07/20.
//

import UIKit
import RxSwift

protocol ViewMainPageRepository {

    var userDTO: PublishSubject<UserPageDTO> { get }
    var mediaDTO: PublishSubject<MediaDTO> { get }
    var imageData: PublishSubject<(String, UIImage, String)> { get }

    func requestPageData()
    func requestMediaData(with id: String)
    func requestNextPageMediaData(with validURL: URL)
}
