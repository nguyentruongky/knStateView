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
        
        view.addSubview(stateView)
        stateView.horizontal(toView: view)
        stateView.centerY(toView: view)
    }
    
    func showCustomErrorView() {
        let imageView = UIMaker.makeImageView(image: UIImage(named: "404"), contentMode: .scaleAspectFit)
        stateView.setCustomView(imageView, for: .error)
        stateView.state = .error
    }
    
    func showCustomLoading() {
        stateView.setContent(image: "loading_2", title: "New loading view", subtitle: "", for: .loading)
        stateView.state = .loading
    }
}
