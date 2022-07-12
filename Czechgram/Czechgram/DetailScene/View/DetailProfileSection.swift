//
//  DetailProfileSectionView.swift
//  Czechgram
//
//  Created by juntaek.oh on 2022/07/11.
//

import UIKit

class DetailProfileSection: UIView {

    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .gray
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false

        return imageView
    }()

    private let profileIDLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.textColor = .black
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()

    private let selectbarView: UIImageView = {
        let bar = UIImageView()
        bar.image = UIImage(systemName: "ellipsis")
        bar.tintColor = .gray
        bar.translatesAutoresizingMaskIntoConstraints = false

        return bar
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setConstraints()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError()
    }

    func configure(image: UIImage, id: String) {
        profileImageView.image = image
        profileIDLabel.text = id
    }

    func setProfileImageViewCornerRound() {
        profileImageView.layer.cornerRadius = profileImageView.frame.width / 2
    }
}

private extension DetailProfileSection {

    func setConstraints() {
        self.addSubviews(profileImageView, profileIDLabel, selectbarView)

        NSLayoutConstraint.activate([
            profileImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15),
            profileImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            profileImageView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.7),
            profileImageView.widthAnchor.constraint(equalTo: profileImageView.heightAnchor)
        ])

        NSLayoutConstraint.activate([
            profileIDLabel.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 15),
            profileIDLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            profileIDLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10)
        ])

        NSLayoutConstraint.activate([
            selectbarView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            selectbarView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            selectbarView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.3),
            selectbarView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.06)
        ])
    }
}
