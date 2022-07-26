//
//  ProfileView.swift
//  Czechgram
//
//  Created by 최예주 on 2022/07/11.
//

import UIKit

final class ProfileView: UIView {

    private var userImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true

        return imageView
    }()

    private var postsButton: UIButton = {
        let button = UIButton(type: .system)
        button.titleLabel?.numberOfLines = 2
        button.tintColor = .black
        button.titleLabel?.textAlignment = .center
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private var followersButton: UIButton = {
        let button = UIButton(type: .system)
        button.titleLabel?.numberOfLines = 2
        button.tintColor = .black
        button.titleLabel?.textAlignment = .center
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private var followingButton: UIButton = {
        let button = UIButton(type: .system)
        button.titleLabel?.numberOfLines = 2
        button.tintColor = .black
        button.titleLabel?.textAlignment = .center
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private var nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private var editButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("프로필 편집", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .systemGray5
        button.tintColor = .black
        button.layer.cornerRadius = 8
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureLayouts()
    }

    @available (*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setProfileData(userName: String, postCount: Int) {
        nameLabel.text = userName
        postsButton.setTitle("\(postCount)\n게시물", for: .normal)
        userImageView.image = UIImage(named: "userImage")
        followersButton.setTitle("24\n팔로워", for: .normal)
        followingButton.setTitle("24\n팔로잉", for: .normal)
    }

    func setUserImageCornerRoundly() {
        userImageView.layer.cornerRadius = userImageView.frame.height/2
    }
}

private extension ProfileView {

    func configureLayouts() {
        addSubviews(userImageView, postsButton, followersButton, followingButton, nameLabel, editButton)

        NSLayoutConstraint.activate([
            userImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            userImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            userImageView.heightAnchor.constraint(equalToConstant: 110),
            userImageView.widthAnchor.constraint(equalTo: userImageView.heightAnchor)
        ])

        NSLayoutConstraint.activate([
            postsButton.leadingAnchor.constraint(greaterThanOrEqualTo: userImageView.trailingAnchor, constant: 20),
            postsButton.centerYAnchor.constraint(equalTo: userImageView.centerYAnchor),
            postsButton.widthAnchor.constraint(equalToConstant: 40),
            postsButton.heightAnchor.constraint(equalToConstant: 40)
        ])

        NSLayoutConstraint.activate([
            followersButton.leadingAnchor.constraint(equalTo: postsButton.trailingAnchor, constant: 30),
            followersButton.centerYAnchor.constraint(equalTo: userImageView.centerYAnchor),
            followersButton.widthAnchor.constraint(equalToConstant: 40),
            followersButton.heightAnchor.constraint(equalToConstant: 40)
        ])

        NSLayoutConstraint.activate([
            followingButton.leadingAnchor.constraint(equalTo: followersButton.trailingAnchor, constant: 30),
            followingButton.centerYAnchor.constraint(equalTo: userImageView.centerYAnchor),

            followingButton.widthAnchor.constraint(equalToConstant: 40),
            followingButton.heightAnchor.constraint(equalToConstant: 40),
            followingButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -30)
        ])

        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            nameLabel.topAnchor.constraint(equalTo: userImageView.bottomAnchor, constant: 10),
            nameLabel.heightAnchor.constraint(equalToConstant: 35),
            nameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20)
        ])

        NSLayoutConstraint.activate([
            editButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            editButton.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10),
            editButton.heightAnchor.constraint(equalToConstant: 35),
            editButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            editButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10)
        ])
    }
}
