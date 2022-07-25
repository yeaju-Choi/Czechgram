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
        collectionView.register(DetailCollectionViewCell.self, forCellWithReuseIdentifier: DetailCollectionViewCell.reuseIdentifier)

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

    private var collectionViewHeightConstraint = [NSLayoutConstraint]()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureLayouts()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError()
    }

    func setCollectionView(delegate: UICollectionViewDelegate, dataSource: UICollectionViewDataSource?) {
        imageSection.delegate = delegate
        imageSection.dataSource = dataSource
    }

    func updateCollectionView(with dataSource: UICollectionViewDataSource?) {
        imageSection.dataSource = dataSource
    }

    func reloadCollectionView(ratio: CGFloat) {
        setImageSectionHeight(ratio: ratio)
        imageSection.reloadData()
    }

    func setProfileData(profile: UIImage, userId: String) {
        profileSection.set(image: profile, id: userId)
    }

    func setDescriptionData(profile: UIImage, userId: String, likePeople: String, description: String) {
        descriptionSection.set(image: profile, likeLine: "\(userId)\(likePeople)", description: description, date: "2022년 7월 11일")
    }

    func setUserImageRoundly() {
        profileSection.setProfileImageViewCornerRoundly()
        descriptionSection.setProfileImageViewCornerRoundly()
    }

    func getImageCellSize(ratio: CGFloat) -> CGSize {
        let width = imageSection.frame.width
        let height = width * ratio

        return CGSize(width: width, height: height)
    }
}

private extension DetailView {

    func configureLayouts() {
        addSubviews(profileSection, imageSection, buttonSection, descriptionSection)

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
            imageSection.widthAnchor.constraint(equalTo: self.widthAnchor)
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

    func setImageSectionHeight(ratio: CGFloat) {
        NSLayoutConstraint.deactivate(collectionViewHeightConstraint)

        let viewHeight = imageSection.frame.width * ratio

        collectionViewHeightConstraint = [imageSection.heightAnchor.constraint(equalToConstant: viewHeight)]
        NSLayoutConstraint.activate(collectionViewHeightConstraint)
    }
}
