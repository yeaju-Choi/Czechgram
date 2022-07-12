//
//  LoginViewController.swift
//  Czechgram
//
//  Created by juntaek.oh on 2022/07/12.
//

import UIKit

final class LoginViewController: UIViewController {

    private let instaLoginButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(.init(named: "Instagram-Icon"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false

        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureLayouts()
        configureInstaLoginButton()
    }
}

private extension LoginViewController {

    func configureLayouts() {
        view.addSubview(instaLoginButton)

        NSLayoutConstraint.activate([
            instaLoginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            instaLoginButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            instaLoginButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5),
            instaLoginButton.heightAnchor.constraint(equalTo: instaLoginButton.widthAnchor)
        ])
    }

    func configureInstaLoginButton() {
        let homeVC = HomeViewController()
        let navi = UINavigationController(rootViewController: homeVC)
        navi.modalPresentationStyle = .fullScreen

        if #available(iOS 14.0, *) {
            let action = UIAction { _ in
                self.present(navi, animated: true)
            }
            instaLoginButton.addAction(action, for: .touchDown)
        } else {
            instaLoginButton.addTarget(self, action: #selector(presentNextScene(to:)), for: .touchDown)
        }
    }

    @objc
    func presentNextScene(to viewController: UIViewController) {
        self.present(viewController, animated: true)
    }
}
