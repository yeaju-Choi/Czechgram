//
//  NetworkServiceable.swift
//  Czechgram
//
//  Created by juntaek.oh on 2022/07/12.
//

import UIKit
import RxSwift

protocol NetworkServiceable {

    func request(endPoint: EndPoint) -> Single<Data>
    func requestImage(url: URL) -> Single<Data>
}
