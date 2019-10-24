//
//  StateDemoController.swift
//  StateViewDemo
//
//  Created by Ky Nguyen on 3/6/19.
//  Copyright © 2019 Ky Nguyen. All rights reserved.
//

import UIKit
class StateDemoController: UIViewController {
    
    let stateView = knStateView()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }
    
    func showState(_ state: knState) {
        stateView.show(state: state, in: view)
    }
    
    func showCustomErrorView() {
        let iv = UIImageView(image: UIImage(named: "404"))
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        stateView.setCustomView(iv, for: .error)
        stateView.show(state: .error, in: view)
    }
    
    func showCustomLoading() {
        stateView.setContent(image: "loading_2",
                             title: "New loading view",
                             subtitle: "",
                             for: .loading)
        stateView.show(state: .loading, in: view)
    }
}
