//
//  ViewController.swift
//  MovieMate
//
//  Created by Farid Rustamov on 01.01.25.
//

import UIKit

class HomeVC: UIViewController {
    
    @IBOutlet private var controllerView: UIView!
    @IBOutlet private weak var collection: UICollectionView!
    
    let viewModel = HomeViewModel()
    let dataManager = WatchListCoreData()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        configureVieWModel()
    }
    
    func configureUI() {
        collection.delegate = self
        collection.dataSource = self
        
        navigationController?.navigationBar.barTintColor = UIColor(named: "BackgroundColor")
        collection.backgroundColor = UIColor(named: "BackgroundColor")
        controllerView.backgroundColor = UIColor(named: "BackgroundColor")
        
        collection.register(UINib(nibName: "MovieCell", bundle: nil),
                            forCellWithReuseIdentifier: "MovieCell")
        collection.register(UINib(nibName: "HeaderReusableView", bundle: nil),
                            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                            withReuseIdentifier: "HeaderReusableView")
        collection.register(UINib(nibName: "SegmentCell", bundle: nil),
                            forCellWithReuseIdentifier: "SegmentCell")
    }
    
    func configureVieWModel() {
        viewModel.getMovies()
        viewModel.getCategories()
        
        viewModel.callBack = { [weak self] in
            self?.collection.reloadData()
        }
    }
}

extension HomeVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if !viewModel.filteredMovieList.isEmpty {
            return viewModel.filteredMovieList.count + 1
        } else {
            return viewModel.movieList.count + 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.item != 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(MovieCell.self)", for: indexPath) as! MovieCell
            let movieList = viewModel.filteredMovieList.isEmpty ? viewModel.movieList : viewModel.filteredMovieList
            cell.callElement(movie: movieList[indexPath.item - 1].posterImage ?? "")
            
            return cell
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(SegmentCell.self)", for: indexPath) as! SegmentCell
        if !viewModel.isSegmentCellConfigured {
            cell.configure(data: viewModel.categoryList)
            viewModel.isSegmentCellConfigured = true
        }
        cell.categoryTapped = { [weak self] category in
            self?.viewModel.filterMoviesByCategory(category: category)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let controller = storyboard?.instantiateViewController(identifier: "\(MovieDetailVC.self)") as? MovieDetailVC
        if viewModel.filteredMovieList.isEmpty {
            controller?.viewModel.movieDetail = viewModel.movieList[indexPath.item - 1]
            navigationController?.show(controller ?? UIViewController(), sender: nil)
        } else {
            controller?.viewModel.movieDetail = viewModel.filteredMovieList[indexPath.item - 1]
            navigationController?.show(controller ?? UIViewController(), sender: nil)
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.item == 0 {
            return CGSize(width: 393, height: 50)
        } else {
            return CGSize(width: 100, height: 145)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "HeaderReusableView", for: indexPath) as! HeaderReusableView
        header.configure(data: viewModel.movieList)
        header.movieTapped = { [weak self] movie in
            let controller = self?.storyboard?.instantiateViewController(identifier: "\(MovieDetailVC.self)") as? MovieDetailVC
            controller?.viewModel.movieDetail = movie
            self?.navigationController?.show(controller ?? UIViewController(), sender: nil)
        }
        
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        .init(width: collectionView.frame.width, height: 250)
    }
}
