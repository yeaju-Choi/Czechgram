//
//  ViewController.swift
//  Czechgram
//
//  Created by 최예주 on 2022/07/10.
//

import UIKit

final class DetailViewController: UIViewController {
    
    private var detailViewModel: DetailViewModel
    private let userId: String

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

    init(cellEntity: MediaImageEntity, userId: String) {
        self.detailViewModel = DetailViewModel(cellEntity: cellEntity)
        self.userId = userId
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureLayouts()
        setSectionsData()
        setCollectionView()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        detailView.setUserImageRoundly()
    }
}

private extension DetailViewController {

    func configureLayouts() {
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
        detailView.setProfileData(profile: UIImage(), userId: userId)
        detailView.setDescriptionData(profile: UIImage(), userId: "yeyeju_", likePeople: "님 외 12명이 좋아합니다", description: """
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
        dataSource = CollectionViewDatasource([UIImage(systemName: "heart")!, UIImage(systemName: "heart.fill")!], reuseIdentifier: DetailCollectionViewCell.reuseIdentifier, cellConfigurator: { (image: UIImage, cell: DetailCollectionViewCell) in
            cell.set(image: image)
        })

        detailView.setCollectionView(delegate: self, dataSource: self.dataSource)
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
