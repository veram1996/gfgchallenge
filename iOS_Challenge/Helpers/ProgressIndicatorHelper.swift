//
//  ProgressIndicatorHelper.swift
//  iOS_Challenge
//
//  Created by Dheeraj Verma on 28/08/21.
//

import Foundation
import UIKit

class  ProgressIndicatorHelper {
    static let sharedInstance = ProgressIndicatorHelper()
    
    private var isProgressIndicatorVisible = false
    var activityIndicator = UIActivityIndicatorView(style: .large)
    var progressView: UIView!
    
    private init() {}
    
    func show() {
        if isProgressIndicatorVisible {
            return
        }
        isProgressIndicatorVisible = true
        let window = UIApplication.shared.windows.first { $0.isKeyWindow }!
        progressView = UIView()
        progressView?.backgroundColor = UIColor(named: "blackTranslucent")
        progressView?.frame = UIScreen.main.bounds
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.startAnimating()
        activityIndicator.color = .white
        progressView?.addSubview(activityIndicator)
        
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            activityIndicator.widthAnchor.constraint(equalToConstant: 125),
            activityIndicator.heightAnchor.constraint(equalToConstant: 125),
            activityIndicator.centerXAnchor.constraint(equalTo: progressView!.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: progressView!.centerYAnchor)
        ])
        
        activityIndicator.startAnimating()
        window.addSubview(progressView!)
    }
    
    func hide() {
        if let progressView = progressView {
            activityIndicator.stopAnimating()
            progressView.removeFromSuperview()
            isProgressIndicatorVisible = false
        }
    }
}
