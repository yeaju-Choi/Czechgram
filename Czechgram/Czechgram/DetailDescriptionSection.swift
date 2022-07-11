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

    private let likeDescriptionView: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15)
        label.textColor = .black
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()

    private let contentDescriptionView: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15)
        label.textColor = .black
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()

    private let dateView: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13)
        label.textColor = .gray
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setSubViews()
        setConstraints()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError()
    }

    func configure(image: UIImage, id: String, description: String) {
        profileImageView.image = image
        likeDescriptionView.text = id
        contentDescriptionView.text = description
        dateView.text = "2022년 7월 11일"
    }

    func setProfileImageViewCornerRound() {
        profileImageView.layer.cornerRadius = profileImageView.frame.width / 2
    }
}

private extension DetailDescriptionSection {

    func setSubViews() {
        self.addSubviews(likeLine, contentDescriptionView, dateView)
        self.likeLine.addSubviews(profileImageView, likeDescriptionView)
    }

    func setConstraints() {
        NSLayoutConstraint.activate([
            likeLine.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            likeLine.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            likeLine.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            likeLine.heightAnchor.constraint(equalToConstant: 25),

            profileImageView.leadingAnchor.constraint(equalTo: likeLine.leadingAnchor, constant: 15),
            profileImageView.topAnchor.constraint(equalTo: likeLine.topAnchor),
            profileImageView.bottomAnchor.constraint(equalTo: likeLine.bottomAnchor),
            profileImageView.widthAnchor.constraint(equalTo: likeLine.heightAnchor),

            likeDescriptionView.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 5),
            likeDescriptionView.trailingAnchor.constraint(equalTo: likeLine.trailingAnchor, constant: -15),
            likeDescriptionView.topAnchor.constraint(equalTo: likeLine.topAnchor),
            likeDescriptionView.bottomAnchor.constraint(equalTo: likeLine.bottomAnchor),

            contentDescriptionView.topAnchor.constraint(equalTo: likeLine.bottomAnchor, constant: 10),
            contentDescriptionView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15),
            contentDescriptionView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15),

            dateView.topAnchor.constraint(equalTo: contentDescriptionView.bottomAnchor, constant: 10),
            dateView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15),
            dateView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15)
        ])
    }
}
