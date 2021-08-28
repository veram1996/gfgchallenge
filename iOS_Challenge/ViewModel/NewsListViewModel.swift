//
//  NewsListViewModel.swift
//  iOS_Challenge
//
//  Created by Dheeraj Verma on 27/08/21.
//

import Foundation

class NewsListViewModel {
    private var serviceManager: ServiceManager?
    private var success: (() -> Void)?
    private var error: ((_ error: ErrorResponse) -> Void)?
    
    var news: News? {
        didSet {
            success?()
        }
    }
    
    init() {
        serviceManager = ServiceManager(delegate: self)
    }
    
    func getNewsList(success: (() -> Void)?, error: ((_ error: ErrorResponse) -> Void)?) {
        self.success = success
        self.error = error
        serviceManager?.requestGETWithURL(StringConstants.url, returningClass: News.self)
        
    }
}
extension NewsListViewModel: ApiResponseReceiver {
    func onSuccess<T>(_ response: T) where T : Decodable {
        if let news = response as? News {
            self.news = news
        }
    }
    
    func onDetailError(_ error: ErrorResponse) {
        self.error?(error)
    }
}
