//
//  Observable.swift
//  Czechgram
//
//  Created by juntaek.oh on 2022/07/13.
//

import Foundation

//final class Observable<T> {
//    typealias Listener = ((T) -> Void)
//
//    private var listener: Listener?
//    private(set) var value: T {
//        didSet {
//            listener?(value)
//        }
//    }
//
//    init(_ value: T) {
//        self.value = value
//    }
//
//    func bind(listener: @escaping Listener) {
//        self.listener = listener
//    }
//
//    func updateValue(value: T) {
//        self.value = value
//    }
//}
