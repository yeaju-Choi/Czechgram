//
//  ViewController.swift
//  Czechgram
//
//  Created by 최예주 on 2022/07/10.
//

import UIKit

class DetailViewController: UIViewController {

    private var dataSource: CollectionViewDatasource<UIImage, DetailCollectionViewCell>?

    private let detailScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.backgroundColor = .white
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false

        return scrollView
    }()

    private let detailView: DetailView = {
        let detailView = DetailView()
        detailView.translatesAutoresizingMaskIntoConstraints = false
        detailView.backgroundColor = .white

        return detailView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setConstraints()
        setSectionsData()
        setCollectionView()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        detailView.setUPUserImageRoundly()
    }
}

private extension DetailViewController {

    func setConstraints() {
        view.addSubview(detailScrollView)
        detailScrollView.addSubview(detailView)

        NSLayoutConstraint.activate([
            detailScrollView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            detailScrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            detailScrollView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            detailScrollView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        ])

        NSLayoutConstraint.activate([
            detailView.topAnchor.constraint(equalTo: detailScrollView.topAnchor),
            detailView.bottomAnchor.constraint(equalTo: detailScrollView.bottomAnchor),
            detailView.leadingAnchor.constraint(equalTo: detailScrollView.leadingAnchor),
            detailView.trailingAnchor.constraint(equalTo: detailScrollView.trailingAnchor),
            detailView.widthAnchor.constraint(equalTo: detailScrollView.widthAnchor)
        ])
    }

    func setSectionsData() {
        detailView.setUPProfileData(profile: UIImage(), userId: "zeto_h_jt")
        detailView.setUPDescriptionData(profile: UIImage(), userId: "yeyeju_", likePeople: "님 외 12명이 좋아합니다", description: """
                        zeto_h_jt 견생 중 가장 장발일 때
                        #말티즈 #사진빨 #빡빡이
                        ------------------
                        ------------------
                        ------------------
                        ------------------
                        ------------------
                        ------------------
                        ------------------
                        """)
    }

    func setCollectionView() {
        let dataSource = CollectionViewDatasource([UIImage(systemName: "heart")!, UIImage(systemName: "heart.fill")!], reuseIdentifier: DetailCollectionViewCell.cellID, cellConfigurator: { (image: UIImage, cell: DetailCollectionViewCell) in
            cell.configure(image: image)
        })

        self.dataSource = dataSource
        detailView.setUPCollectionView(delegate: self, dataSource: dataSource)
    }
}

extension DetailViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // 추가 구현 예정
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        return detailView.getImageCellSize()
    }
}
