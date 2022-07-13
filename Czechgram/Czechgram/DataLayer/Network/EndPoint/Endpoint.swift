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
        return "https://"
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
        default:
            return ""
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
        default:
            return ["Content-type": "application/json",
                    "Accept": "application/json"]
        }
    }

    var queryItems: [URLQueryItem]? {
        switch self {
        case .instagramAuthorize:
            // TODO: 실제 값으로 변경해야 함
            
            return [URLQueryItem(name: "client_id", value: "3180795768850143"),
             URLQueryItem(name: "redirect_uri", value: "https://socialsizzle.heroku.com/auth/"),
             URLQueryItem(name: "response_type", value: "code"),
             URLQueryItem(name: "scope", value: "user_profile, user_media")
             ]
            
        case .requestToken(let code):
            return [URLQueryItem(name: "client_id", value: "3180795768850143"),
             URLQueryItem(name: "client_secret", value: "f641f554a2c5adc9adb5676eba521f8d"),
             URLQueryItem(name: "code", value: "AQBx-hBsH3..."),
             URLQueryItem(name: "grant_type", value: "\(code)")
             ]
        
        default:
            return nil
        }
    }
    
    var url: URL? {
        var components = URLComponents()
        components.scheme = self.scheme
        components.host = self.host
        components.path = self.path ?? ""
        components.queryItems = self.queryItems
        
        return components.url
    }

}
