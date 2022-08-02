//
//  SceneDelegate.swift
//  Czechgram
//
//  Created by 최예주 on 2022/07/10.
//

import UIKit
import RxSwift

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var dispose: DisposeBag?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }

        dispose = DisposeBag()

        if let token = UserDefaults.standard.object(forKey: "accessToken") as? String, let disposeBag = dispose {
            let networkService = NetworkService()
            networkService.request(endPoint: .userPage(token: token))
                .observe(on: ConcurrentMainScheduler.instance)
                .subscribe { [weak self] _ in
                    self?.window = UIWindow(windowScene: windowScene)
                    let mainViewController = HomeViewController()
                    let naviController = UINavigationController(rootViewController: mainViewController)

                    self?.window?.rootViewController = naviController
                    self?.window?.makeKeyAndVisible()

                } onFailure: { [weak self] _ in
                    self?.window = UIWindow(windowScene: windowScene)
                    let mainViewController = LoginViewController()

                    self?.window?.rootViewController = mainViewController
                    self?.window?.makeKeyAndVisible()

                }.disposed(by: disposeBag)

        } else {
            DispatchQueue.main.async {
                self.window = UIWindow(windowScene: windowScene)
                let mainViewController = LoginViewController()

                self.window?.rootViewController = mainViewController
                self.window?.makeKeyAndVisible()
            }
        }
//            networkService.request(endPoint: EndPoint.userPage(token: token)) { result in
//                switch result {
//                case .success:
//                    DispatchQueue.main.async {
//                        self.window = UIWindow(windowScene: windowScene)
//                        let mainViewController = HomeViewController()
//                        let naviController = UINavigationController(rootViewController: mainViewController)
//
//                        self.window?.rootViewController = naviController
//                        self.window?.makeKeyAndVisible()
//                    }
//
//                case .failure:
//                    DispatchQueue.main.async {
//                        self.window = UIWindow(windowScene: windowScene)
//                        let mainViewController = LoginViewController()
//
//                        self.window?.rootViewController = mainViewController
//                        self.window?.makeKeyAndVisible()
//                    }
//                }
//            }
//
//        } else {
//            DispatchQueue.main.async {
//                self.window = UIWindow(windowScene: windowScene)
//                let mainViewController = LoginViewController()
//
//                self.window?.rootViewController = mainViewController
//                self.window?.makeKeyAndVisible()
//            }
//        }
    }

    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        guard let url = URLContexts.first?.url, let grantCode = url.absoluteString.components(separatedBy: "code=").last else { return }

        NotificationCenter.default.post(name: NSNotification.Name("GrantCode"), object: nil, userInfo: ["GrantCode": grantCode])
    }
}
