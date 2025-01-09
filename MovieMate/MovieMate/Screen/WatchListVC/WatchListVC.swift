//
//  WatchListVC.swift
//  MovieMate
//
//  Created by Farid Rustamov on 02.01.25.
//

import UIKit

class WatchListVC: UIViewController {
    
    @IBOutlet var controllerView: UIView!
    @IBOutlet weak var table: UITableView!
    
    var watchList: [WatchList] = []
    let dataManager = WatchListCoreData()
    let movieDetailVC = MovieDetailVC()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        fetchData()
    }
    
    func configureUI() {
        table.delegate = self
        table.dataSource = self
        
        navigationItem.title = "Watch List"
        navigationController?.navigationBar.barTintColor = UIColor(named: "BackgroundColor")
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        
        table.register(UINib(nibName: "WatchListCell", bundle: nil), forCellReuseIdentifier: "WatchListCell")
    }
    
    @objc func updateWatchList() {
        dataManager.fetchWatchList {
            self.watchList = self.dataManager.watchList
            self.table.reloadData()
        }
    }
    
    func fetchData() {
        dataManager.fetchWatchList {
            self.watchList = self.dataManager.watchList
            self.table.reloadData()
        }
        NotificationCenter.default.addObserver(self, selector: #selector(updateWatchList), name: Notification.Name("WatchListUpdated"), object: nil)
//        movieDetailVC.success = {
//            self.dataManager.fetchWatchList {
//                self.watchList = self.dataManager.watchList
//                self.table.reloadData()
//            }
//        }
    }
}

extension WatchListVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        watchList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WatchListCell", for: indexPath) as! WatchListCell
        let data = watchList[indexPath.row]
        
        cell.callElement(posterImage: data.posterImage ?? "", movie: data.movieName ?? "", rating: data.rating, category: data.categoryId ?? "", year: data.releaseDate ?? "", duration: data.time ?? "")
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        watchList.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .fade)
        tableView.reloadData()
    }
}
