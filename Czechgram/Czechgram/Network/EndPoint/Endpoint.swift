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

    var base: String {
        switch self {
        case .instagramAuthorize:
            return "https://api.instagram.com"
        default:
            return ""
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

    var parameter: [String: String]? {
        switch self {
        case .instagramAuthorize:
            // TODO: 실제 값으로 변경해야 함
            return ["client_id": "3180795768850143",
                    "redirect_uri": "https://socialsizzle.heroku.com/auth/",
                    "response_type": "code",
                    "scope": "user_profile, user_media"]
            
        case .requestToken(let code):
            // TODO: 실제 값으로 변경해야 함
            return ["client_id": "3180795768850143",
                    "client_secret": "f641f554a2c5adc9adb5676eba521f8d",
                    "code": "AQBx-hBsH3...",
                    "grant_type": "\(code)"]

        default:
            return nil
        }
    }

}
