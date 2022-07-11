//
//  DetailProfileSectionView.swift
//  Czechgram
//
//  Created by juntaek.oh on 2022/07/11.
//

import UIKit

class DetailProfileSectionView: UIView {

    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .gray
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false

        return imageView
    }()

    private let profileIDView: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .bold)
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
        setSubViews()
        setConstraints()
        setProfileImageViewCornerRound()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError()
    }

    func configureProfile(image: UIImage, id: String) {
        profileImageView.image = image
        profileIDView.text = id
    }
}

private extension DetailProfileSectionView {

    func setSubViews() {
        self.addSubview(profileImageView)
        self.addSubview(profileIDView)
        self.addSubview(selectbarView)
    }

    func setConstraints() {
        NSLayoutConstraint.activate([
            profileImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15),
            profileImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            profileImageView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.7),
            profileImageView.widthAnchor.constraint(equalTo: profileImageView.heightAnchor),

            profileIDView.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 15),
            profileIDView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            profileIDView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),

            selectbarView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            selectbarView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            selectbarView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.3),
            selectbarView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.06)
        ])
    }

    func setProfileImageViewCornerRound() {
        profileImageView.layer.cornerRadius = 28
    }
}
