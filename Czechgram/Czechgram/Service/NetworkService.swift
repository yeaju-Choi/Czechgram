//
//  NetworkService.swift
//  Czechgram
//
//  Created by juntaek.oh on 2022/07/12.
//

import Foundation

struct NetworkService: NetworkServiceable {
    
    static func request(endPoint: EndPoint, completion: @escaping CompletionHandler) {
        var urlRequest = URLRequest(url: endPoint.url)
        urlRequest.httpMethod = endPoint.method
        urlRequest.setValue(endPoint.headerValue, forHTTPHeaderField: endPoint.headerType)
        urlRequest.httpBody = endPoint.body
        
        URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            guard let !error = error else {
                completion(.failure(.transportError(error)))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                completion(.failure(.serverError(statusCode: httpResponse.statusCode)))
                return
            }
            
            completion(.success(data))
        }.resume()
    }
}
