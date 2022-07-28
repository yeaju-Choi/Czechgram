//
//  JSONConverter.swift
//  Czechgram
//
//  Created by juntaek.oh on 2022/07/20.
//

import Foundation
import RxSwift

struct JSONConverter<T: Codable> {

    typealias Model = T

    func decode(data: Data) -> Single<Model> {
        Single<Model>.create { observer -> Disposable in
            guard let json = try? JSONDecoder().decode(Model.self, from: data) else {
                observer(.failure(NetworkError.decodingError))
                return Disposables.create()
            }
            
            observer(.success(json))
            return Disposables.create()
        }
    }

    func encode(model: Model) -> Single<Data> {
        Single<Data>.create { observer -> Disposable in
            guard let data = try? JSONEncoder().encode(model) else {
                observer(.failure(NetworkError.encodingError))
                return Disposables.create()
            }
            
            observer(.success(data))
            return Disposables.create()
        }
    }
}
