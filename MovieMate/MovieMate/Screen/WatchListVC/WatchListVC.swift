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
    
    var watchList: [MovieModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        getMovies()
    }
    
    func configureUI() {
        table.delegate = self
        table.dataSource = self
        
        table.register(UINib(nibName: "WatchListCell", bundle: nil), forCellReuseIdentifier: "WatchListCell")
    }
    
    func getMovies() {
        if let fileUrl = Bundle.main.url(forResource: "Movies", withExtension: "json") {
            do {
                let data = try Data(contentsOf: fileUrl)
                watchList = try JSONDecoder().decode([MovieModel].self, from: data)
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}

extension WatchListVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        watchList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WatchListCell", for: indexPath) as! WatchListCell
        let data = watchList[indexPath.row]
        
        cell.callElement(posterImage: data.posterImage ?? "", movie: data.movieName ?? "", rating: data.rating ?? 0, category: data.category?.categoryName ?? "", year: data.releaseDate ?? "", duration: data.time ?? "")
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        watchList.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .fade)
        tableView.reloadData()
    }
}
