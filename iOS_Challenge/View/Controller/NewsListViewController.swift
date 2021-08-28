//
//  NewsListViewController.swift
//  iOS_Challenge
//
//  Created by Dheeraj Verma on 27/08/21.
//

import UIKit

class NewsListViewController: UIViewController {
    
    private var newsListViewModel: NewsListViewModel?
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "NewsItemTableViewCell", bundle: nil), forCellReuseIdentifier: "NewsItemTableViewCell")
        newsListViewModel = NewsListViewModel()
        tableView.delegate = self
        tableView.dataSource = self
        getNewsList()
        
    }
  
    private func getNewsList() {
        newsListViewModel?.getNewsList()
        newsListViewModel?.success = {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        
        newsListViewModel?.error = { error in
            
        }
    }
}

extension NewsListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsListViewModel?.news?.items?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  tableView.dequeueReusableCell(withIdentifier: "NewsItemTableViewCell", for: indexPath) as! NewsItemTableViewCell
        guard let item = newsListViewModel?.news?.items?[indexPath.row] else { return cell}
        cell.configCell(item: item)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
