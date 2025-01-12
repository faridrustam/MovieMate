//
//  MovieSearchVC.swift
//  MovieMate
//
//  Created by Farid Rustamov on 02.01.25.
//

import UIKit

class MovieSearchVC: UIViewController {
    
    @IBOutlet private var controllerView: UIView!
    @IBOutlet private weak var backgroundSearch: UIView!
    @IBOutlet private weak var searchTextField: UITextField!
    @IBOutlet private weak var collection: UICollectionView!
    
    let viewModel = MovieSearchViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        viewModel.getMovies()
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
        viewModel.movieSearchChange(searchTextField: searchTextField.text ?? "") {
            self.collection.reloadData()
        }
    }
}

extension MovieSearchVC: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if viewModel.filteredMovies.count > 0 {
            return viewModel.filteredMovies.count
        } else {
            return viewModel.movies.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(MovieCell.self)", for: indexPath) as! MovieCell
        
        if viewModel.filteredMovies.count > 0 {
            cell.callElement(movie: viewModel.filteredMovies[indexPath.item].posterImage ?? "")
        } else {
            cell.callElement(movie: viewModel.movies[indexPath.item].posterImage ?? "")
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let controller = storyboard?.instantiateViewController(withIdentifier: "\(MovieDetailVC.self)") as? MovieDetailVC
        if !viewModel.filteredMovies.isEmpty {
            controller?.viewModel.movieDetail = viewModel.filteredMovies[indexPath.item]
        } else {
            controller?.viewModel.movieDetail = viewModel.movies[indexPath.item]
        }
        
        navigationController?.show(controller ?? UIViewController(), sender: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        .init(width: 180, height: 300)
    }
}
