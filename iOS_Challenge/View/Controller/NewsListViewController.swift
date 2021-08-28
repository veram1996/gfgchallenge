//
//  NewsListViewController.swift
//  iOS_Challenge
//
//  Created by Dheeraj Verma on 27/08/21.
//

import UIKit

class NewsListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    private var newsListViewModel: NewsListViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(NewsItemTableViewCell.nib(), forCellReuseIdentifier: "NewsItemTableViewCell")
        tableView.register(TopNewsTableViewCell.nib(), forCellReuseIdentifier: "TopNewsTableViewCell")
        newsListViewModel = NewsListViewModel()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        getNewsList()
    }
    
    private func getNewsList() {
        ProgressIndicatorHelper.sharedInstance.show()
        newsListViewModel?.getNewsList(success: { [weak self] in
            guard let self = self else { return }
            DispatchQueue.main.async {
                ProgressIndicatorHelper.sharedInstance.hide()
                self.tableView.reloadData()
            }
        }, error: { [weak self] response in
            guard let self = self else { return }
            ProgressIndicatorHelper.sharedInstance.hide()
            self.showAlert(title: response.error ?? "Error", errorMessage: response.message ?? "Something went wrong")
        })
    }
    
    private func showAlert(title: String, errorMessage: String) {
        let okAction = UIAlertAction(title: "OK", style: .cancel)
        let alertControl = UIAlertController(title: title,
                                             message: errorMessage,
                                             preferredStyle: .alert)
        alertControl.addAction(okAction)
        present(alertControl, animated: true, completion: nil)
    }
}

extension NewsListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsListViewModel?.news?.items?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row ==  0 {
            let cell =  tableView.dequeueReusableCell(withIdentifier: "TopNewsTableViewCell", for: indexPath) as! TopNewsTableViewCell
            guard let item = newsListViewModel?.news?.items?[indexPath.row] else { return cell}
            cell.configCell(item: item)
            return cell
        } else {
            let cell =  tableView.dequeueReusableCell(withIdentifier: "NewsItemTableViewCell", for: indexPath) as! NewsItemTableViewCell
            guard let item = newsListViewModel?.news?.items?[indexPath.row] else { return cell}
            cell.configCell(item: item)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 460
        } else {
            return 140
        }
    }
}
