//
//  DetailButton.swift
//  Czechgram
//
//  Created by juntaek.oh on 2022/07/11.
//

import UIKit

class DetailButtonSection: UIView {

    private let leftStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 10
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false

        return stackView
    }()

    private let heartImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "heart")
        imageView.tintColor = .black
        imageView.sizeToFit()

        return imageView
    }()

    private let commentImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "message")
        imageView.tintColor = .black
        imageView.sizeToFit()

        return imageView
    }()

    private let messageImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "paperplane")
        imageView.tintColor = .black
        imageView.sizeToFit()

        return imageView
    }()

    private let scrapImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "bookmark")
        imageView.tintColor = .black
        imageView.sizeToFit()
        imageView.translatesAutoresizingMaskIntoConstraints = false

        return imageView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureLayouts()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError()
    }
}

private extension DetailButtonSection {

    func configureLayouts() {
        self.addSubviews(leftStackView, scrapImageView)
        leftStackView.addArrangedSubviews(heartImageView, commentImageView, messageImageView)

        NSLayoutConstraint.activate([
            leftStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15),
            leftStackView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            leftStackView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.7),
            leftStackView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.3)
        ])

        NSLayoutConstraint.activate([
            scrapImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            scrapImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            scrapImageView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.5),
            scrapImageView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.08)
        ])
    }
}
