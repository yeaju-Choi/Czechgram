//
//  JSONConverter.swift
//  Czechgram
//
//  Created by juntaek.oh on 2022/07/20.
//

import Foundation

struct JSONConverter<T: Codable> {

    typealias Model = T

    func decode(data: Data) -> Model? {
        do {
            let decodedData = try JSONDecoder().decode(Model.self, from: data)
            return decodedData
        } catch {
            print(NetworkError.decodingError(error))
            return nil
        }
    }

    func encode(model: Model) -> Data? {
        do {
            let encodedData = try JSONEncoder().encode(model)
            return encodedData
        } catch {
            print(NetworkError.encodingError(error))
            return nil
        }
    }
}
