//
//  HomeCollectionViewDataSource.swift
//  Czechgram
//
//  Created by 최예주 on 2022/07/11.
//

import UIKit

class HomeCollectionViewDataSource: NSObject, UICollectionViewDataSource {

    let dummyData: [String] = ["userImage", "userImage", "userImage", "userImage", "userImage", "userImage", "userImage", "userImage", "userImage", "userImage", "userImage", "userImage", "userImage", "userImage", "userImage", "userImage", "userImage", "userImage", "userImage", "userImage", "userImage"]

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dummyData.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PostCell.reuseIdentifier, for: indexPath) as? PostCell else { return UICollectionViewCell() }
        let image = UIImage(named: dummyData[indexPath.item]) ?? UIImage()
        cell.setImage(image: image)

        return cell

    }

}

extension HomeCollectionViewDataSource: UICollectionViewDelegateFlowLayout {
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

}
