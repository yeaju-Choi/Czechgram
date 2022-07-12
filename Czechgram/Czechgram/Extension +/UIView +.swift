//
//  UIView +.swift
//  Czechgram
//
//  Created by juntaek.oh on 2022/07/11.
//

import UIKit

extension UIView {

    func addSubviews(_ views: UIView...) {
        views.forEach {
            addSubview($0)
        }
    }
}
