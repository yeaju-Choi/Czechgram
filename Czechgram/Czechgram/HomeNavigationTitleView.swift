//
//  HomeNavigationTitleView.swift
//  Czechgram
//
//  Created by 최예주 on 2022/07/11.
//

import UIKit

final class HomeNavigationTitleView: UIView {

    private var idLabel: UILabel = {
        let label = UILabel()
        label.text = "czech01"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 22)
        label.textAlignment = .left
        return label
    }()

    private var postButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(.init(systemName: "plus.app"), for: .normal)
        button.tintColor = .black
        return button
    }()

    private var menuButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(.init(systemName: "line.3.horizontal"), for: .normal)
        button.tintColor = .black
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        addSubviews()
        setLayout()

    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

private extension HomeNavigationTitleView {
    func addSubviews() {
        self.addSubview(idLabel)
        self.addSubview(menuButton)
        self.addSubview(postButton)
    }

    func setLayout() {

        NSLayoutConstraint.activate([
            idLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            idLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            idLabel.heightAnchor.constraint(equalToConstant: 24),
            idLabel.widthAnchor.constraint(equalToConstant: 200)
        ])

        NSLayoutConstraint.activate([
            menuButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 10),
            menuButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            menuButton.widthAnchor.constraint(equalToConstant: 20),
            menuButton.heightAnchor.constraint(equalToConstant: 20)
        ])

        NSLayoutConstraint.activate([
            postButton.trailingAnchor.constraint(equalTo: self.menuButton.leadingAnchor, constant: -10),
            postButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            postButton.widthAnchor.constraint(equalToConstant: 20),
            postButton.heightAnchor.constraint(equalToConstant: 20),
            postButton.leadingAnchor.constraint(greaterThanOrEqualTo: idLabel.trailingAnchor, constant: 50)
        ])

    }
}
