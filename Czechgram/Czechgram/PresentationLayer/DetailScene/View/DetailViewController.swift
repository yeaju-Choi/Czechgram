////
////  ViewController.swift
////  Czechgram
////
////  Created by 최예주 on 2022/07/10.
////
//
// import UIKit
//
// final class DetailViewController: UIViewController {
//
//    private var detailViewModel: DetailViewModel
//    private let userId: String
//
//    private var dataSource: CollectionViewDatasource<MediaImageEntity, DetailCollectionViewCell>?
//
//    private let detailScrollView: UIScrollView = {
//        let scrollView = UIScrollView()
//        scrollView.translatesAutoresizingMaskIntoConstraints = false
//        scrollView.backgroundColor = .white
//        scrollView.showsVerticalScrollIndicator = false
//        scrollView.showsHorizontalScrollIndicator = false
//
//        return scrollView
//    }()
//
//    private let detailView: DetailView = {
//        let detailView = DetailView()
//        detailView.translatesAutoresizingMaskIntoConstraints = false
//        detailView.backgroundColor = .white
//
//        return detailView
//    }()
//
//    private var imageRatio: CGFloat = 0
//
//    init(cellEntity: MediaImageEntity, userId: String) {
//        self.detailViewModel = DetailViewModel(cellEntity: cellEntity)
//        self.userId = userId
//        super.init(nibName: nil, bundle: nil)
//    }
//
//    @available (*, unavailable)
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        view.backgroundColor = .white
//        configureLayouts()
//        setSectionsData()
//        setCollectionView()
//        configureBinding()
//        detailViewModel.enquireImages()
//    }
//
//    override func viewDidLayoutSubviews() {
//        super.viewDidLayoutSubviews()
//        detailView.setUserImageRoundly()
//    }
// }
//
// private extension DetailViewController {
//
//    func configureLayouts() {
//        view.addSubview(detailScrollView)
//        detailScrollView.addSubview(detailView)
//
//        NSLayoutConstraint.activate([
//            detailScrollView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
//            detailScrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
//            detailScrollView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
//            detailScrollView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
//        ])
//
//        NSLayoutConstraint.activate([
//            detailView.topAnchor.constraint(equalTo: detailScrollView.topAnchor),
//            detailView.bottomAnchor.constraint(equalTo: detailScrollView.bottomAnchor),
//            detailView.leadingAnchor.constraint(equalTo: detailScrollView.leadingAnchor),
//            detailView.trailingAnchor.constraint(equalTo: detailScrollView.trailingAnchor),
//            detailView.widthAnchor.constraint(equalTo: detailScrollView.widthAnchor)
//        ])
//    }
//
//    func setSectionsData() {
//        detailView.setProfileData(profile: UIImage(), userId: userId)
//        detailView.setDescriptionData(profile: UIImage(), userId: "yeyeju_", likePeople: "님 외 12명이 좋아합니다", description: """
//                        zeto_h_jt 견생 중 가장 장발일 때
//                        #말티즈 #사진빨 #빡빡이
//                        ------------------
//                        ------------------
//                        ------------------
//                        ------------------
//                        ------------------
//                        ------------------
//                        ------------------
//                        """)
//    }
//
//    func setCollectionView() {
//        detailView.setCollectionView(delegate: self, dataSource: nil)
//    }
//
//    func configureBinding() {
//        detailViewModel.myPageData.bind { [weak self] entities in
//            guard let entities = entities, let firstImage = entities[0].image else { return }
//            let ratio = firstImage.size.height / firstImage.size.width
//            self?.imageRatio = ratio
//            self?.dataSource = CollectionViewDatasource(entities, reuseIdentifier: DetailCollectionViewCell.reuseIdentifier, cellConfigurator: { (entity: MediaImageEntity, cell: DetailCollectionViewCell) in
//                guard let image = entity.image else { return }
//                cell.set(image: image)
//            })
//
//            DispatchQueue.main.async {
//                self?.detailView.updateCollectionView(with: self?.dataSource)
//                self?.detailView.reloadCollectionView(ratio: ratio)
//            }
//        }
//    }
// }
//
// extension DetailViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        // 추가 구현 예정
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//
//        return detailView.getImageCellSize(ratio: imageRatio)
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        return 0
//    }
// }
