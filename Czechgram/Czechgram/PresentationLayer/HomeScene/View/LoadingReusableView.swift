//
//  LoadingReusableView.swift
//  Czechgram
//
//  Created by 최예주 on 2022/07/25.
//

import UIKit

final class LoadingReusableView: UICollectionReusableView {

    var homeVM = HomeViewModel()
    static let reuseIdentifier = "LoadingFooter"

    private(set) var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.translatesAutoresizingMaskIntoConstraints = false
//        indicator.hidesWhenStopped = true
        indicator.stopAnimating()
        return indicator

    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .clear
        configureLayouts()
    }

    @available (*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

//    func loadAddtionalData() {
//        self.activityIndicator.startAnimating()
//        homeVM.enquireNextImages()
//    }

}

private extension LoadingReusableView {

    func configureLayouts() {
        self.addSubview(activityIndicator)

        NSLayoutConstraint.activate([
            activityIndicator.topAnchor.constraint(equalTo: self.topAnchor),
            activityIndicator.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            activityIndicator.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            activityIndicator.bottomAnchor.constraint(equalTo: self.bottomAnchor)

        ])
    }
}
