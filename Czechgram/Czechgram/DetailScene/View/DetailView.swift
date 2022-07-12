//
//  DetailView.swift
//  Czechgram
//
//  Created by juntaek.oh on 2022/07/11.
//

import UIKit

final class DetailView: UIView {

    private let profileSection: DetailProfileSection = {
        let section = DetailProfileSection()
        section.translatesAutoresizingMaskIntoConstraints = false
        section.backgroundColor = .white

        return section
    }()

    private let imageSection: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)

        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .white
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.register(DetailCollectionViewCell.self, forCellWithReuseIdentifier: DetailCollectionViewCell.cellID)

        return collectionView
    }()

    private let buttonSection: DetailButtonSection = {
        let section = DetailButtonSection()
        section.translatesAutoresizingMaskIntoConstraints = false
        section.backgroundColor = .white

        return section
    }()

    private let descriptionSection: DetailDescriptionSection = {
        let section = DetailDescriptionSection()
        section.translatesAutoresizingMaskIntoConstraints = false
        section.backgroundColor = .white

        return section
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

    func setUPCollectionView(delegate: UICollectionViewDelegate, dataSource: UICollectionViewDataSource) {
        imageSection.delegate = delegate
        imageSection.dataSource = dataSource
    }

    func setUPProfileData(profile: UIImage, userId: String) {
        profileSection.configure(image: profile, id: userId)
    }

    func setUPDescriptionData(profile: UIImage, userId: String, likePeople: String, description: String) {
        descriptionSection.configure(image: profile, likeLine: "\(userId)\(likePeople)", description: description, date: "2022년 7월 11일")
    }

    func setUPUserImageRoundly() {
        profileSection.setProfileImageViewCornerRound()
        descriptionSection.setProfileImageViewCornerRound()
    }

    func getImageCellSize() -> CGSize {
        let width = imageSection.frame.width
        let height = imageSection.frame.height

        return CGSize(width: width, height: height)
    }
}

private extension DetailView {

    func setSubViews() {
        addSubviews(profileSection, imageSection, buttonSection, descriptionSection)
    }

    func setConstraints() {
        NSLayoutConstraint.activate([
            profileSection.topAnchor.constraint(equalTo: self.topAnchor),
            profileSection.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            profileSection.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            profileSection.widthAnchor.constraint(equalTo: self.widthAnchor),
            profileSection.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.08)
        ])

        NSLayoutConstraint.activate([
            imageSection.topAnchor.constraint(equalTo: profileSection.bottomAnchor),
            imageSection.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            imageSection.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            imageSection.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.6)
        ])

        NSLayoutConstraint.activate([
            buttonSection.topAnchor.constraint(equalTo: imageSection.bottomAnchor),
            buttonSection.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            buttonSection.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            buttonSection.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.05)
        ])

        NSLayoutConstraint.activate([
            descriptionSection.topAnchor.constraint(equalTo: buttonSection.bottomAnchor),
            descriptionSection.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            descriptionSection.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
    }
}
