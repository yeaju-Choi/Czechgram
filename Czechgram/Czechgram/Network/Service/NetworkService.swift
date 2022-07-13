//
//  NetworkService.swift
//  Czechgram
//
//  Created by juntaek.oh on 2022/07/12.
//

import Foundation

struct NetworkService: NetworkServiceable {

    static func request(endPoint: EndPoint, completion: @escaping CompletionHandler) {

        let request = makeURLRequest(with: endPoint)
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let httpResponse = response as? HTTPURLResponse else { return }

            if let error = error {
                completion(.failure(.transportError(error)))
                return
            }

            guard (200...299).contains(httpResponse.statusCode) else {
                completion(.failure(.serverError(statusCode: httpResponse.statusCode)))
                return
            }

            guard let data = data else {
                completion(.failure(.noData))
                return
            }

            completion(.success(data))
        }.resume()
    }

    static func makeURLRequest(with target: EndPoint) -> URLRequest {
        guard var url = URL(string: target.base) else {
            preconditionFailure("invalid base url")
        }

        if let path = target.path {
            url = url.appendingPathComponent(path)
        }

        var components = URLComponents(string: "\(url)")

        if let queryParam = target.parameter {
            components?.queryItems = queryParam.map { URLQueryItem(name: $0, value: $1)
            }
        }

        guard let validURL = components?.url else {
            preconditionFailure("invalid url components")
        }
        var request = URLRequest(url: validURL)

        if let header = target.contentType {
            header.forEach { (key, value) in
                request.addValue(key, forHTTPHeaderField: value)
            }
            request.httpMethod = target.httpMethod.value
        }

        return request
    }
}
