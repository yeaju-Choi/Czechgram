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
        switch request {
        case .failure(_):
            completion(.failure(.noURL))
            
        case .success(let request):
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
    }

    static func makeURLRequest(with target: EndPoint) -> Result<URLRequest, NetworkError> {
        guard let url = target.url else { return .failure(.noData) }
        
        var request = URLRequest(url: url)

        if let header = target.contentType {
            header.forEach { (key, value) in
                request.addValue(key, forHTTPHeaderField: value)
            }
            request.httpMethod = target.httpMethod.value
        }

        return .success(request)
    }
}
