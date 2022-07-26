//
//  HomeViewController.swift
//  Czechgram
//
//  Created by 최예주 on 2022/07/11.
//

import UIKit

final class HomeViewController: UIViewController {

    private var homeVM = HomeViewModel()

    private var profileView = ProfileView()
    private var datasource: CollectionViewDatasource<MediaImageEntity, PostCell>?
    private var isLoading = false

    private var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.backgroundColor = .white
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()

    private var contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.footerReferenceSize = CGSize(width: 370, height: 50)
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.isScrollEnabled = false
        collectionView.register(PostCell.self, forCellWithReuseIdentifier: PostCell.reuseIdentifier)
        collectionView.register(LoadingReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: LoadingReusableView.reuseIdentifier)
        collectionView.delegate = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()

    private var contentViewHeightConstraint = [NSLayoutConstraint]()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.scrollView.delegate = self
        setNavigationController()
        configureLayouts()
        configureBind()
        homeVM.enquireAllData()
    }

    override func viewDidLayoutSubviews() {
        profileView.setUserImageCornerRoundly()
    }
}

private extension HomeViewController {

    func configureBind() {
        homeVM.myPageData.bind { [weak self] userPageData in
            guard let userPageData = userPageData else { return }
            self?.datasource = CollectionViewDatasource(userPageData.media.images, reuseIdentifier: PostCell.reuseIdentifier) { (imageData: MediaImageEntity, cell: PostCell) in
                guard let image = imageData.image else { return }
                cell.set(image: image)
            }

            DispatchQueue.main.async { [weak self] in
                self?.profileView.setProfileData(userName: userPageData.userName, postCount: userPageData.mediaCount)
                self?.collectionView.dataSource = self?.datasource
                self?.setContentViewHeight(imagesCount: userPageData.media.images.count)
                self?.collectionView.reloadData()
                self?.scrollView.setNeedsLayout()
                self?.isLoading = false
            }
        }
    }

    func setNavigationController() {
        let titleView = HomeNavigationTitleView()
        self.navigationItem.titleView = titleView
    }

    func configureLayouts() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubviews(profileView, collectionView)

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])

        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])

        profileView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            profileView.topAnchor.constraint(equalTo: contentView.topAnchor),
            profileView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            profileView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            profileView.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            profileView.heightAnchor.constraint(equalToConstant: 220)
        ])

        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: profileView.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            collectionView.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            collectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }

    func setContentViewHeight(imagesCount: Int) {
        NSLayoutConstraint.deactivate(contentViewHeightConstraint)

        let row = imagesCount % 3 == 0 ? imagesCount / 3 : imagesCount / 3 + 1

        let cellHeight = Int(collectionView.frame.width / 3 - 1)
        let contentViewHeight = CGFloat((cellHeight * row) + (1 * row) + 220 + 60)

        contentViewHeightConstraint = [contentView.heightAnchor.constraint(equalToConstant: contentViewHeight)]
        NSLayoutConstraint.activate(contentViewHeightConstraint)
    }
}

 extension HomeViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

     func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
         guard let cellEntity = homeVM.myPageData.value?.media.images[indexPath.row], let id = homeVM.myPageData.value?.userName else { return }
         let detailVC = DetailViewController(cellEntity: cellEntity, userId: id)
         self.navigationController?.pushViewController(detailVC, animated: true)
     }

     func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
         let width = collectionView.frame.width / 3 - 1
         return CGSize(width: width, height: width)
     }

     func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
         return 1
     }

     func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
         return 1
     }

     // MARK: Loading Footer Settings
     func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {

         if homeVM.isFetchAllData || !isLoading {
             return CGSize.zero
         } else {
             return CGSize(width: collectionView.frame.width, height: 50)
         }
     }

     // footer appear
     func collectionView(_ collectionView: UICollectionView, willDisplaySupplementaryView view: UICollectionReusableView, forElementKind elementKind: String, at indexPath: IndexPath) {
             guard let footer = view as? LoadingReusableView else { return }

         if elementKind == UICollectionView.elementKindSectionFooter && isLoading {
                     footer.activityIndicator.startAnimating()
             } else {
                 footer.activityIndicator.stopAnimating()
             }

         }

     // footer disappear
     func collectionView(_ collectionView: UICollectionView, didEndDisplayingSupplementaryView view: UICollectionReusableView, forElementOfKind elementKind: String, at indexPath: IndexPath) {
             if elementKind == UICollectionView.elementKindSectionFooter {
                 guard let footer = view as? LoadingReusableView else { return }
                 footer.activityIndicator.stopAnimating()
             }
         }
 }

extension HomeViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {

        let scrollViewHeight = scrollView.frame.size.height
        let scrollOffset = scrollView.contentOffset.y
        if !homeVM.isFetchAllData && !isLoading && (scrollViewHeight - scrollOffset < 30) {
            isLoading = true

            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
            homeVM.enquireNextImages()
        }

    }
}
