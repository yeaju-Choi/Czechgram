//
//  LoginViewController.swift
//  Czechgram
//
//  Created by juntaek.oh on 2022/07/12.
//

import UIKit
import RxSwift

final class LoginViewController: UIViewController {

    var loginVM = LoginViewModel()
    
    let disposeBag = DisposeBag()

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
        configureObservableBinding()
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
                self.loginVM.enquireInstaToken()
            }
            instaLoginButton.addAction(action, for: .touchDown)
        } else {
            instaLoginButton.addTarget(self, action: #selector(presentNextScene(to:)), for: .touchDown)
        }
    }

    @objc
    func presentNextScene(to viewController: UIViewController) {
        self.loginVM.enquireInstaToken()
    }

    func configureObservableBinding() {
        loginVM.instaOAuthPageURL
            .subscribe(onNext: { url in
                UIApplication.shared.open(url)
                
            })
            .disposed(by: disposeBag)

        loginVM.isFetchedOAuthToken
            .observe(on: ConcurrentMainScheduler.instance)
            .subscribe(onNext: { isFetched in
                if isFetched {
                    let homeVC = HomeViewController()
                    let navigation = UINavigationController(rootViewController: homeVC)
                    navigation.modalPresentationStyle = .fullScreen
                    self.present(navigation, animated: true)
                    
                } else {
                    let alert = UIAlertController(title: "Ooops!", message: "Failed to convert AccessToken, check it again", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .cancel))
                    self.present(alert, animated: true)
                }
            })
            .disposed(by: disposeBag)
    }
}
