//
//  DetailDescriptionView.swift
//  Czechgram
//
//  Created by juntaek.oh on 2022/07/11.
//

import UIKit

class DetailDescriptionSection: UIView {

    private let likeLine: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false

        return view
    }()

    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .gray
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false

        return imageView
    }()

    private let likeDescriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15)
        label.textColor = .black
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()

    private let contentDescriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15)
        label.textColor = .black
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()

    private let dateLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13)
        label.textColor = .gray
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setConstraints()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError()
    }

    func configure(image: UIImage, likeLine: String, description: String, date: String) {
        profileImageView.image = image
        likeDescriptionLabel.text = likeLine
        contentDescriptionLabel.text = description
        dateLabel.text = date
    }

    func setProfileImageViewCornerRound() {
        profileImageView.layer.cornerRadius = profileImageView.frame.width / 2
    }
}

private extension DetailDescriptionSection {

    func setConstraints() {
        self.addSubviews(likeLine, contentDescriptionLabel, dateLabel)
        self.likeLine.addSubviews(profileImageView, likeDescriptionLabel)

        NSLayoutConstraint.activate([
            likeLine.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            likeLine.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            likeLine.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            likeLine.heightAnchor.constraint(equalToConstant: 25)
        ])

        NSLayoutConstraint.activate([
            profileImageView.leadingAnchor.constraint(equalTo: likeLine.leadingAnchor, constant: 15),
            profileImageView.topAnchor.constraint(equalTo: likeLine.topAnchor),
            profileImageView.bottomAnchor.constraint(equalTo: likeLine.bottomAnchor),
            profileImageView.widthAnchor.constraint(equalTo: likeLine.heightAnchor)
        ])

        NSLayoutConstraint.activate([
            likeDescriptionLabel.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 5),
            likeDescriptionLabel.trailingAnchor.constraint(equalTo: likeLine.trailingAnchor, constant: -15),
            likeDescriptionLabel.topAnchor.constraint(equalTo: likeLine.topAnchor),
            likeDescriptionLabel.bottomAnchor.constraint(equalTo: likeLine.bottomAnchor)
        ])

        NSLayoutConstraint.activate([
            contentDescriptionLabel.topAnchor.constraint(equalTo: likeLine.bottomAnchor, constant: 10),
            contentDescriptionLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15),
            contentDescriptionLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15)
        ])

        NSLayoutConstraint.activate([
            dateLabel.topAnchor.constraint(equalTo: contentDescriptionLabel.bottomAnchor, constant: 10),
            dateLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15),
            dateLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15)
        ])
    }
}
