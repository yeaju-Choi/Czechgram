//
//  SceneDelegate.swift
//  Czechgram
//
//  Created by 최예주 on 2022/07/10.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)

        // TODO: 후에 변경 해야함
        let mainViewController = LoginViewController()

        window?.rootViewController = mainViewController
        window?.makeKeyAndVisible()
    }

    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        guard let url = URLContexts.first?.url, let grantCode = url.absoluteString.components(separatedBy: "code=").last else { return }

        NetworkService.request(endPoint: .shortLivedToken(code: grantCode)) { result in
            switch result {
            case .success(let data):
                      guard let jsonData = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
                      let accessToken = jsonData["access_token"] as? String,
                      let userID = jsonData["user_id"] as? UInt else { return }
                UserDefaults.standard.set(userID, forKey: "userID")

                NetworkService.request(endPoint: .longLivedToken(token: accessToken)) { result in
                    switch result {
                    case .success(let data):
                        guard let jsonData = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
                        let accessToken = jsonData["access_token"] as? String else { return }
                        UserDefaults.standard.set(accessToken, forKey: "accessToken")
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }

            case .failure(let error):
                print(error.localizedDescription)
            }

        }

    }
}
