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

    var base: URL? {
        switch self {
        case .instagramAuthorize:
            return URL(string: "https://api.instagram.com")
        default:
            return URL(string: "")
        }
    }

    var path: String {
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

    var parameter: [String: Any]? {
        switch self {

        case .requestToken(let code):
            // TODO: 실제 값으로 변경해야 함
            return ["client_id": "990602627938098",
                    "client_secret": "a1b2C3D4",
                    "code": "AQBx-hBsH3...",
                    "grant_type": "\(code)"]

        case .instagramAuthorize:
            // TODO: 실제 값으로 변경해야 함
            return ["client_id": "990602627938098",
                    "redirect_uri": "https://socialsizzle.herokuapp.com/auth/",
                    "response_type": "code",
                    "scope": "user_profile,user_media"]
        default:
            return nil
        }
    }

}
