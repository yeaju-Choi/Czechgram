//
//  HomeViewController.swift
//  Czechgram
//
//  Created by 최예주 on 2022/07/11.
//

import UIKit

final class HomeViewController: UIViewController {

    private var profileView = ProfileView()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        setNavigationController()
        addSubviews()
        setLayouts()
    }

    override func viewDidLayoutSubviews() {
        profileView.setUserImageCornerRound()
    }
}

private extension HomeViewController {

    func setNavigationController() {
        let titleView = HomeNavigationTitleView()
        self.navigationItem.titleView = titleView
    }

    func addSubviews() {
        view.addSubview(profileView)

    }

    func setLayouts() {
        profileView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            profileView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            profileView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            profileView.widthAnchor.constraint(equalTo: self.view.widthAnchor),
            profileView.heightAnchor.constraint(equalToConstant: 220)
        ])
    }
}
