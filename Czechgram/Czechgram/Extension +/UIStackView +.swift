//
//  UIStackView +.swift
//  Czechgram
//
//  Created by juntaek.oh on 2022/07/12.
//

import UIKit

extension UIStackView {

    func addArrangedSubviews(_ views: UIView...) {
        views.forEach {
            addArrangedSubview($0)
        }
    }
}
