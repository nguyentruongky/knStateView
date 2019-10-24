//
//  ViewController.swift
//  StateViewDemo
//
//  Created by Ky Nguyen on 3/6/19.
//  Copyright © 2019 Ky Nguyen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let stackView = UIStackView(frame: CGRect(x: 0, y: 100, width: UIScreen.main.bounds.width, height: 200))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.alignment = .center
        stackView.spacing = 12
        
        view.addSubview(stackView)
        
        let emptyButton = addButton(title: "Show Empty")
        emptyButton.addTarget(self, action: #selector(showEmptyState), for: .touchUpInside)
        
        let noInternetButton = addButton(title: "Show No internet")
        noInternetButton.addTarget(self, action: #selector(showNoInternet), for: .touchUpInside)
        
        let loadingButton = addButton(title: "Show loading")
        loadingButton.addTarget(self, action: #selector(showLoading), for: .touchUpInside)
        
        let customLoadingButton = addButton(title: "Show custom loading")
        customLoadingButton.addTarget(self, action: #selector(showCustomLoading), for: .touchUpInside)
        
        let genericErrorButton = addButton(title: "Show error")
        genericErrorButton.addTarget(self, action: #selector(showError), for: .touchUpInside)
        
        let customErrorButton = addButton(title: "Show custom error")
        customErrorButton.addTarget(self, action: #selector(showCustomError), for: .touchUpInside)
    }
    
    @objc func showEmptyState() {
        showStateDemo(state: .empty)
    }
    
    @objc func showNoInternet() {
        showStateDemo(state: .noInternet)
    }
    
    @objc func showError() {
        showStateDemo(state: .error)
    }
    
    @objc func showLoading() {
        showStateDemo(state: .loading)
    }
    
    @objc func showCustomLoading() {
        let controller = StateDemoController()
        controller.showCustomLoading()
        navigationController?.pushViewController(controller, animated: true)
    }
    
    func showStateDemo(state: knState) {
        let controller = StateDemoController()
        controller.showState(state)
        navigationController?.pushViewController(controller, animated: true)
    }
    
    @objc func showCustomError() {
        let controller = StateDemoController()
        controller.showCustomErrorView()
        navigationController?.pushViewController(controller, animated: true)
    }
    
    func addButton(title: String) -> UIButton {
        let button = UIButton()
        button.setTitle(title, for: .normal)
        button.setTitleColor(.blue, for: .normal)
        stackView.addArrangedSubview(button)
        return button
    }


}

