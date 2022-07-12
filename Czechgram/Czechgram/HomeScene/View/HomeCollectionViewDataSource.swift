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
