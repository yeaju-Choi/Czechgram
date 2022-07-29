//
//  ViewMyPageRepository.swift
//  Czechgram
//
//  Created by juntaek.oh on 2022/07/20.
//

import UIKit
import RxSwift

protocol ViewMainPageRepository {

    func requestPageData() -> Observable<UserPageDTO>
    func requestMediaData(with id: String) -> Observable<(UIImage, String)>
    func requestNextPageMediaData(with validURL: URL) -> Observable<MediaDTO> 
//    func requestPageData(for completion: @escaping (UserPageDTO?) -> Void)
//    func requestMediaData(with id: String, for completion: @escaping (UIImage?, String?) -> Void)
//    func requestNextPageMediaData(with validURL: URL, for completion: @escaping (MediaDTO?) -> Void)
}
