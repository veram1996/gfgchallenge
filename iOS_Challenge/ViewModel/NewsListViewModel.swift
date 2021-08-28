//
//  NewsListViewModel.swift
//  iOS_Challenge
//
//  Created by Dheeraj Verma on 27/08/21.
//

import Foundation

class NewsListViewModel {
    private var serviceManager: ServiceManager?
    var success: (() -> Void)?
    var error: ((_ error: ErrorResponse) -> Void)?
    
    var news: News? {
        didSet {
            success?()
        }
    }
    
    init() {
        serviceManager = ServiceManager(delegate: self)
    }
   
    func getNewsList() {
        serviceManager?.requestGETWithURL("https://api.rss2json.com/v1/api.json?rss_url=http://www.abc.net.au/news/feed/51120/rss.xml", returningClass: News.self)
        
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
