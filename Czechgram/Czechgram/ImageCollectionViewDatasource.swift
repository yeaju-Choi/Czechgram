//
//  DetailCollectionViewDatasource.swift
//  Czechgram
//
//  Created by juntaek.oh on 2022/07/11.
//

import UIKit

final class ImageCollectionViewDatasource<Image: UIImage, Cell: UICollectionViewCell>: NSObject, UICollectionViewDataSource {

    typealias CellConfigurator = (Image, Cell) -> Void

    private var images: [Image]?
    private let reuseIdentifier: String
    private let cellConfigurator: CellConfigurator

    init(_ images: [Image]?, reuseIdentifier: String, cellConfigurator: @escaping CellConfigurator) {
        self.images = images
        self.reuseIdentifier = reuseIdentifier
        self.cellConfigurator = cellConfigurator
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let images = images else { return 0 }

        return images.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? Cell, let images = images else { return UICollectionViewCell() }

        cellConfigurator(images[indexPath.row], cell)
        return cell
    }
}
