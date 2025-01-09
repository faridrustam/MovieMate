//
//  MovieSearchVC.swift
//  MovieMate
//
//  Created by Farid Rustamov on 02.01.25.
//

import UIKit

class MovieSearchVC: UIViewController {
    
    @IBOutlet private var controllerView: UIView!
    @IBOutlet weak private var backgroundSearch: UIView!
    @IBOutlet weak private var searchTextField: UITextField!
    @IBOutlet weak private var collection: UICollectionView!
    
    var movies: [MovieModel] = []
    var filteredMovies: [MovieModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        getMovies()
    }
    
    func configureUI() {
        navigationItem.title = "Search"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        backgroundSearch.layer.cornerRadius = backgroundSearch.frame.height / 2
        backgroundSearch.backgroundColor = UIColor(named: "SearchBarColor")
        searchTextField.attributedPlaceholder = NSAttributedString(string: "Search", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        controllerView.backgroundColor = UIColor(named: "BackgroundColor")
        collection.backgroundColor = UIColor(named: "BackgroundColor")
        collection.delegate = self
        collection.dataSource = self
        collection.register(UINib(nibName: "MovieCell", bundle: nil), forCellWithReuseIdentifier: "MovieCell")
        searchTextField.addTarget(self, action: #selector(searchTextChanged), for: .editingChanged)
    }
    
    @objc func searchTextChanged() {
        if let text = searchTextField.text {
            if text.isEmpty {
                filteredMovies = movies
                collection.reloadData()
            } else {
                filterSearch()
            }
        }
    }
    
    func filterSearch() {
        filteredMovies = movies.filter {
            ($0.movieName?.lowercased().contains(searchTextField.text?.lowercased() ?? "") ?? false) ||
            ($0.categoryId?.lowercased().contains(searchTextField.text?.lowercased() ?? "") ?? false)
        }
        collection.reloadData()
    }
    
    func getMovies() {
        if let fileUrl = Bundle.main.url(forResource: "Movies", withExtension: "json") {
            do {
                let data = try Data(contentsOf: fileUrl)
                movies = try JSONDecoder().decode([MovieModel].self, from: data)
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}

extension MovieSearchVC: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if filteredMovies.count > 0 {
            return filteredMovies.count
        } else {
            return movies.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(MovieCell.self)", for: indexPath) as! MovieCell
        
        if filteredMovies.count > 0 {
            cell.callElement(movie: filteredMovies[indexPath.item].posterImage ?? "")
        } else {
            cell.callElement(movie: movies[indexPath.item].posterImage ?? "")
        }
        return cell
    }
    
        func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            let controller = storyboard?.instantiateViewController(withIdentifier: "\(MovieDetailVC.self)") as? MovieDetailVC
            controller?.movieDetail = movies[indexPath.item]
            
            navigationController?.show(controller ?? UIViewController(), sender: nil)
        }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        .init(width: 180, height: 300)
    }
    
}
