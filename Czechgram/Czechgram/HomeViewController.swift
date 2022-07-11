//
//  HomeViewController.swift
//  Czechgram
//
//  Created by 최예주 on 2022/07/11.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        setNavigationController()

    }

    func setNavigationController() {

        let titleView = HomeNavigationTitleView()
        self.navigationItem.titleView = titleView

    }

}
