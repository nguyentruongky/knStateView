//
//  knStateview.swift
//  SnapShop
//
//  Created by Ky Nguyen Coinhako on 10/16/18.
//  Copyright © 2018 Ky Nguyen. All rights reserved.
//

import UIKit

enum knState: String {
    case success
    case noInternet
    case error, empty, loading
}

class knStateView: knView {
    private var currentView: UIView?
    private var customViews = [knState: UIView]()
    private let imgView = UIMaker.makeImageView()
    private let titleLabel = UIMaker.makeLabel(font: UIFont.boldSystemFont(ofSize: 17),
                                               color: UIColor.darkGray,
                                               numberOfLines: 2, alignment: .center)
    private let contentLabel = UIMaker.makeLabel(font: UIFont.systemFont(ofSize: 17),
                                                 color: UIColor.lightGray,
                                                 numberOfLines: 2, alignment: .center)
    private let container = UIMaker.makeStackView()
    
    private var contents = [
        knState.noInternet: (icon: "no_internet",
                             title: "Oops, no connection",
                             subtitle: "The internet connection appears to be offline."),
        knState.error: (icon: "generic_error",
                        title: "There's an error",
                        subtitle: "There was an error. Please try again later."),
        knState.empty: (icon: "empty",
                        title: "No content",
                        subtitle: "I am lonly here"),
        knState.loading: (icon: "loading",
                          title: "Give me seconds",
                          subtitle: ""),
        ]
    
    var state = knState.success {
        didSet {
            guard state != oldValue else { return }
            setState(state)
        }
    }
    
    func show(state: knState, in view: UIView, space: UIEdgeInsets = .zero) {
        view.addSubviews(views: self)
        fill(toView: view, space: space)
        
        self.state = state
    }
    
    override func setupView() {
        backgroundColor = .white
        translatesAutoresizingMaskIntoConstraints = false
        container.addArrangedSubview(imgView)
        container.addArrangedSubview(titleLabel)
        container.addArrangedSubview(contentLabel)
        imgView.centerX(toView: container)
        imgView.width(toView: container, multiplier: 0.5, greater: 0)
        imgView.square()
        
        titleLabel.horizontal(toView: container, space: 16)
        contentLabel.horizontal(toView: titleLabel)
        
        addSubviews(views: container)
        container.horizontal(toView: self)
        container.centerY(toView: self, space: -75)
    }
}

extension knStateView {
    func setCustomView(_ view: UIView, for state: knState) {
        customViews[state] = view
    }
    
    func setContent(image: String, title: String = "", subtitle: String = "", for state: knState) {
        contents[state] = (image, title, subtitle)
    }
}

extension knStateView {
    private func downloadImage(urlString: String) {
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data) else { return }
            DispatchQueue.main.async() { [weak self] in self?.imgView.image = image }
            }.resume()
    }
    
    private func setState(_ value: knState) {
        currentView?.removeFromSuperview()
        
        if let view = customViews[value] {
            currentView = view
            addSubviews(views: view)
            view.center(toView: self)
            return
        }
        
        if let data = contents[value] {
            setData(data)
            return
        }
        
        if value == .success {
            removeFromSuperview()
        }
    }
    
    private func setData(_ data: (icon: String, title: String, subtitle: String)) {
        if state == .loading {
            imgView.loadGif(name: data.icon)
        } else if data.icon.contains("http") {
            downloadImage(urlString: data.icon)
        } else {
            imgView.image = UIImage(named: data.icon)
        }
        
        titleLabel.text = data.title
        contentLabel.text = data.subtitle
        
        if data.icon.isEmpty {
            imgView.removeFromSuperview()
        }
        
        if data.title.isEmpty {
            titleLabel.removeFromSuperview()
        }
        
        if data.subtitle.isEmpty {
            contentLabel.removeFromSuperview()
        }
    }
}
