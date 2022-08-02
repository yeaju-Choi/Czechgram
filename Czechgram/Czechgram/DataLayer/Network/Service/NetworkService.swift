//
//  NetworkService.swift
//  Czechgram
//
//  Created by juntaek.oh on 2022/07/12.
//

import Foundation
import RxSwift

struct NetworkService: NetworkServiceable {

    func request(endPoint: EndPoint) -> Single<Data> {
        return Single<Data>.create { observer -> Disposable in
            let request = makeURLRequest(with: endPoint)
            switch request {
            case .failure:
                observer(.failure(NetworkError.noURL))
                return Disposables.create()

            case .success(let request):
                URLSession.shared.dataTask(with: request) { (data, response, error) in
                    guard let httpResponse = response as? HTTPURLResponse else { return }

                    if let error = error {
                        observer(.failure(NetworkError.transportError(error)))
                        return
                    }

                    guard (200...299).contains(httpResponse.statusCode) else {
                        observer(.failure(NetworkError.serverError(statusCode: httpResponse.statusCode)))
                        return
                    }

                    guard let data = data else {
                        observer(.failure(NetworkError.noData))
                        return
                    }

                    observer(.success(data))
                }.resume()

                return Disposables.create()
            }
        }
    }

    func requestImage(url: URL) -> Single<Data> {
        return Single<Data>.create { observer -> Disposable in
            URLSession.shared.dataTask(with: url) { data, response, error in
                guard let httpResponse = response as? HTTPURLResponse else { return }

                if let error = error {
                    observer(.failure(NetworkError.transportError(error)))
                    return
                }

                guard (200...299).contains(httpResponse.statusCode) else {
                    observer(.failure(NetworkError.serverError(statusCode: httpResponse.statusCode)))
                    return
                }

                guard let data = data else {
                    observer(.failure(NetworkError.noData))
                    return
                }

                observer(.success(data))
            }.resume()

            return Disposables.create()
        }
    }
}

private extension NetworkService {

    func makeURLRequest(with target: EndPoint) -> Result<URLRequest, NetworkError> {
        guard let url = target.url else { return .failure(.noData) }

        var request = URLRequest(url: url)

        if let header = target.contentType {
            header.forEach { (key, value) in
                request.addValue(value, forHTTPHeaderField: key)
            }
            request.httpMethod = target.httpMethod.value
        }

        switch target.httpMethod {
        case .post:
            let param: [String: String] = (target.queryItems ?? []).reduce(into: [:]) { params, queryItem in
                params[queryItem.name] = queryItem.value

            }
            let formDataString = (param.compactMap({ (key, value) -> String in
              return "\(key)=\(value)"
            }) as Array).joined(separator: "&")

            let formEncodedData = formDataString.data(using: .utf8)
            request.httpBody = formEncodedData

        default:
            break
        }

        return .success(request)
    }
}
