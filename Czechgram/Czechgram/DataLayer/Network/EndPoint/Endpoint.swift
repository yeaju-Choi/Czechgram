//
//  Endpoint.swift
//  Czechgram
//
//  Created by 최예주 on 2022/07/12.
//

import Foundation

enum EndPoint: EndPontable {

    case instagramAuthorize
    case requestToken(code: String)

    var scheme: String {
        return "https"
    }

    var host: String {
        switch self {
        default:
            return "api.instagram.com"
        }

    }

    var path: String? {
        switch self {
        case .instagramAuthorize:
            return "/oauth/authorize"
        case .requestToken:
            return "/oauth/access_token"
        }
    }

    var httpMethod: HTTPMethod {
        switch self {
        case .requestToken:
            return .post
        default:
            return .get
        }
    }

    var contentType: [String: String]? {
        switch self {
        case .requestToken(let code):
            return ["Content-type": "application/x-www-form-urlencoded",
                    "Accept": "application/json"]
        default:
            return ["Content-type": "application/json",
                    "Accept": "application/json"]
        }
    }

    var queryItems: [URLQueryItem]? {
        switch self {
        case .instagramAuthorize:
            // TODO: 실제 값으로 변경해야 함

            return [URLQueryItem(name: "client_id", value: "622682008886100"),
             URLQueryItem(name: "redirect_uri", value: "https://wnsxor1993.github.io/"),
             URLQueryItem(name: "response_type", value: "code"),
             URLQueryItem(name: "scope", value: "user_profile, user_media")
             ]

        case .requestToken(let code):
            return [URLQueryItem(name: "client_id", value: "622682008886100"),
             URLQueryItem(name: "client_secret", value: "2b5c96cee7df4b0e8b5a8a291ed7d747"),
             URLQueryItem(name: "code", value: "\(code)"),
             URLQueryItem(name: "grant_type", value: "authorization_code"),
             URLQueryItem(name: "redirect_uri", value: "https://wnsxor1993.github.io/")
             ]
        }
    }

    var url: URL? {
        var components = URLComponents()
        components.scheme = self.scheme
        components.host = self.host
        components.path = self.path ?? ""
        if self.httpMethod == .get {
        components.queryItems = self.queryItems
        }

        return components.url
    }

}
