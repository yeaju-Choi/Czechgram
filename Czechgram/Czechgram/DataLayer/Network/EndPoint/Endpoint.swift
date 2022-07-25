//
//  Endpoint.swift
//  Czechgram
//
//  Created by 최예주 on 2022/07/12.
//

import Foundation

enum EndPoint: EndPontable {

    case instagramAuthorize
    case shortLivedToken(code: String)
    case longLivedToken(token: String)
    case userPage(token: String)
    case imageUrl(mediaID: String, token: String)

    var scheme: String {
        return "https"
    }

    var host: String {
        switch self {
        case .longLivedToken, .userPage, .imageUrl:
            return "graph.instagram.com"
        default:
            return "api.instagram.com"
        }

    }

    var path: String? {
        switch self {
        case .instagramAuthorize:
            return "/oauth/authorize"
        case .shortLivedToken:
            return "/oauth/access_token"
        case .longLivedToken:
            return "/access_token"
        case .userPage:
            return "/me"
        case .imageUrl(let id, _):
            return "/\(id)"
        }
    }

    var httpMethod: HTTPMethod {
        switch self {
        case .shortLivedToken:
            return .post
        default:
            return .get
        }
    }

    var contentType: [String: String]? {
        switch self {
        case .instagramAuthorize, .longLivedToken, .userPage, .imageUrl:
            return ["Content-type": "application/json",
                    "Accept": "application/json"]
        default:
            return ["Content-type": "application/x-www-form-urlencoded",
                    "Accept": "application/json"]
        }
    }

    var queryItems: [URLQueryItem]? {
        switch self {
        case .instagramAuthorize:
            return [URLQueryItem(name: "client_id", value: "622682008886100"),
             URLQueryItem(name: "redirect_uri", value: "https://wnsxor1993.github.io/"),
             URLQueryItem(name: "response_type", value: "code"),
             URLQueryItem(name: "scope", value: "user_profile, user_media")]

        case .shortLivedToken(let code):
            return [URLQueryItem(name: "client_id", value: "622682008886100"),
             URLQueryItem(name: "client_secret", value: "2b5c96cee7df4b0e8b5a8a291ed7d747"),
             URLQueryItem(name: "code", value: "\(code)"),
             URLQueryItem(name: "grant_type", value: "authorization_code"),
             URLQueryItem(name: "redirect_uri", value: "https://wnsxor1993.github.io/")]

        case .longLivedToken(let token):
            return [URLQueryItem(name: "grant_type", value: "ig_exchange_token"),
                    URLQueryItem(name: "client_secret", value: "2b5c96cee7df4b0e8b5a8a291ed7d747"),
                    URLQueryItem(name: "access_token", value: token)]

        case .userPage(let token):
            return [URLQueryItem(name: "fields", value: "username,media_count,media"),
                    URLQueryItem(name: "access_token", value: token)]

        case .imageUrl(_, let token):
            return [URLQueryItem(name: "fields", value: "id,media_type,media_url,thumbnail_url,timestamp"),
                    URLQueryItem(name: "access_token", value: token)]
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
