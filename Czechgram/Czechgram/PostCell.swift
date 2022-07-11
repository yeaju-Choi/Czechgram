//
//  PostCell.swift
//  Czechgram
//
//  Created by 최예주 on 2022/07/11.
//

import UIKit

class PostCell: UICollectionViewCell {

    static let reuseIdentifier = "PostCell"

    private var postImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addsubViews()
        setLayouts()
    }

    @available (*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setImage(image: UIImage) {
        postImageView.image = image
    }
}

private extension PostCell {

    func addsubViews() {
        contentView.addSubview(postImageView)
    }

    func setLayouts() {
        NSLayoutConstraint.activate([
            postImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            postImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            postImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            postImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}
