//
//  ViewController.swift
//  Czechgram
//
//  Created by 최예주 on 2022/07/10.
//

import UIKit

class ViewController: UIViewController {

    private let detailScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.backgroundColor = .white
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false

        return scrollView
    }()

    private let profileSection: DetailProfileSectionView = {
        let section = DetailProfileSectionView()
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
        collectionView.register(DetailCollectionViewCell.self, forCellWithReuseIdentifier: DetailCollectionViewCell.cellID)

        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setSubViews()
        setConstraints()
        setSectionsData()
    }
}

private extension ViewController {

    func setSubViews() {
        view.addSubview(detailScrollView)
        detailScrollView.addSubview(profileSection)
        detailScrollView.addSubview(imageSection)
    }

    func setConstraints() {
        NSLayoutConstraint.activate([
            detailScrollView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            detailScrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            detailScrollView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            detailScrollView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),

            profileSection.topAnchor.constraint(equalTo: detailScrollView.topAnchor),
            profileSection.leadingAnchor.constraint(equalTo: detailScrollView.leadingAnchor),
            profileSection.trailingAnchor.constraint(equalTo: detailScrollView.trailingAnchor),
            profileSection.widthAnchor.constraint(equalTo: detailScrollView.widthAnchor),
            profileSection.heightAnchor.constraint(equalTo: detailScrollView.heightAnchor, multiplier: 0.1),

            imageSection.topAnchor.constraint(equalTo: profileSection.bottomAnchor),
            imageSection.leadingAnchor.constraint(equalTo: detailScrollView.leadingAnchor),
            imageSection.trailingAnchor.constraint(equalTo: detailScrollView.trailingAnchor),
            imageSection.heightAnchor.constraint(equalTo: detailScrollView.heightAnchor, multiplier: 0.6)
        ])
    }

    func setSectionsData() {
        profileSection.configureProfile(image: UIImage(), id: "zeto_h_jt")
    }

    func setCollectionView() {
        imageSection.delegate = self
    }
}

extension ViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // 추가 구현 예정
    }
}
