//
//  ViewDetailPostRepository.swift
//  Czechgram
//
//  Created by juntaek.oh on 2022/07/25.
//

import UIKit
import RxSwift

protocol ViewDetailPageRepository {

    func requestChildrenData(with id: String) -> Observable<MediaDTO>
    func requestChildrenImage(with id: String) -> Observable<(UIImage, String)>
}
