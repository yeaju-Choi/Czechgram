//
//  HomeViewController.swift
//  Czechgram
//
//  Created by 최예주 on 2022/07/11.
//

import UIKit

final class HomeViewController: UIViewController {

    private var profileView = ProfileView()

    private var scrollView: UIScrollView = {
            let scrollView = UIScrollView()
            scrollView.translatesAutoresizingMaskIntoConstraints = false
            scrollView.backgroundColor = .white
            scrollView.showsVerticalScrollIndicator = false
            return scrollView
        }()

    private let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

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

        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(profileView)

    }

    func setLayouts() {

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])

        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])

        profileView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            profileView.topAnchor.constraint(equalTo: contentView.topAnchor),
            profileView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            profileView.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            profileView.heightAnchor.constraint(equalToConstant: 220)
        ])
    }
}
