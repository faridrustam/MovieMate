//
//  WatchListVC.swift
//  MovieMate
//
//  Created by Farid Rustamov on 02.01.25.
//

import UIKit

class WatchListVC: UIViewController {
    
    @IBOutlet private var controllerView: UIView!
    @IBOutlet private weak var table: UITableView!
    
    let dataManager = WatchListCoreData()
    let viewModel = WatchListViewModel()
    let userDefaultsManager = UserDefaultsManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureRefreshControl()
    }
    
    func configureUI() {
        table.delegate = self
        table.dataSource = self
        
        navigationItem.title = "Watch List"
        navigationController?.navigationBar.barTintColor = UIColor(named: "BackgroundColor")
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        table.register(UINib(nibName: "WatchListCell", bundle: nil), forCellReuseIdentifier: "WatchListCell")
    }
    
    func configureRefreshControl() {
        table.refreshControl = UIRefreshControl()
        table.refreshControl?.addTarget(self, action: #selector(handleRefreshControl), for: .valueChanged)
    }
    
    @objc func handleRefreshControl() {
        dataManager.fetchWatchList {
            self.viewModel.watchList = self.dataManager.watchList
            self.table.reloadData()
        }
        
        DispatchQueue.main.async {
            self.table.refreshControl?.endRefreshing()
        }
    }
}

extension WatchListVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.watchList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WatchListCell", for: indexPath) as! WatchListCell
        let data = viewModel.watchList[indexPath.row]
        
        cell.callElement(posterImage: data.posterImage ?? "", movie: data.movieName ?? "", rating: data.rating, category: data.categoryId ?? "", year: data.releaseDate ?? "", duration: data.time ?? "")
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let controller = storyboard?.instantiateViewController(identifier: "\(MovieDetailVC.self)") as! MovieDetailVC
        let selectedWatchList = viewModel.watchList[indexPath.row]
        controller.viewModel.movieDetail = selectedWatchList.toMovieModel()
        navigationController?.show(controller, sender: nil)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Watched") { (action, view, completionHandler) in
            self.dataManager.deleteWatchList(movie: self.viewModel.watchList[indexPath.row]) {
                self.viewModel.watchList.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .automatic)
                NotificationCenter.default.post(name: Notification.Name("movieDeleted"), object: nil)

                completionHandler(true)
            }
        }
        
        deleteAction.backgroundColor = .systemGreen
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
        return configuration
    }
}

extension WatchList {
    func toMovieModel() -> MovieModel {
        return MovieModel(
            category: self.categoryId,
            movieName: self.movieName,
            backgroundImage: self.bacgroundImage,
            posterImage: self.posterImage,
            rating: self.rating,
            releaseDate: self.releaseDate,
            time: self.time,
            aboutMovie: self.aboutMovie,
            trailer: self.trailer
        )
    }
}
