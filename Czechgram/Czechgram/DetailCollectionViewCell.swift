//
//  DetailCollectionViewCell.swift
//  Czechgram
//
//  Created by juntaek.oh on 2022/07/11.
//

import Foundation
import UIKit

final class DetailCollectionViewCell: UICollectionViewCell {

    static let cellID = "DetailCollectionViewCell"

    private let imageView: UIImageView = {
        let image = UIImageView()
        image.sizeToFit()
        image.translatesAutoresizingMaskIntoConstraints = false

        return image
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setConstraints()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError()
    }

    func configureCell(image: UIImage) {
        imageView.image = image
    }
}

private extension DetailCollectionViewCell {

    func setConstraints() {
        self.addSubview(imageView)

        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: self.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
    }
}
