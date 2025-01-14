//
//  MovieDetailVC.swift
//  MovieMate
//
//  Created by Farid Rustamov on 02.01.25.
//

import UIKit

class MovieDetailVC: UIViewController {
    
    @IBOutlet private var backgroundView: UIView!
    @IBOutlet private weak var collection: UICollectionView!
    
    let viewModel = MovieDetailViewModel()
    let dataManager = WatchListCoreData()
    let userDefaultsManager = UserDefaultsManager()
    
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(handleMovieDeleted), name: Notification.Name("movieDeleted"), object: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        saveBookmark()
    }
    
    func configureUI() {
        collection.delegate = self
        collection.dataSource = self
        navigationItem.title = "Detail"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        
        backgroundView.backgroundColor = UIColor(named: "BackgroundColor")
        collection.backgroundColor = UIColor(named: "BackgroundColor")
        
        collection.register(UINib(nibName: "\(MovieDetailReusableView.self)", bundle: nil),
                            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                            withReuseIdentifier: "\(MovieDetailReusableView.self)")
        collection.register(UINib(nibName: "CategoryDetailCell", bundle: nil),
                            forCellWithReuseIdentifier: "CategoryDetailCell")
        collection.register(UINib(nibName: "DetailCategoryCell", bundle: nil),
                            forCellWithReuseIdentifier: "DetailCategoryCell")
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "bookmark"),
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(bookmarkButtonTapped))
        
    }
    
    func saveBookmark() {
        if let movieName = viewModel.movieDetail?.movieName {
            let isBookmarked = userDefaultsManager.getBookmarkState(movieName: movieName)
            let imageName = isBookmarked ? "bookmark.fill" : "bookmark"
            navigationItem.rightBarButtonItem?.image = UIImage(systemName: imageName)
        }
    }
    
    @objc func handleMovieDeleted() {
        userDefaultsManager.setBookmarkState(movieName: viewModel.movieDetail?.movieName ?? "", isBookmarked: false)
        navigationItem.rightBarButtonItem?.image = UIImage(systemName: "bookmark")
    }

    deinit {
        NotificationCenter.default.removeObserver(self, name: Notification.Name("movieDeleted"), object: nil)
    }
    
    @objc func bookmarkButtonTapped() {
        guard let movieDetail = viewModel.movieDetail else { return }
        let isCurrentlyBookmarked = userDefaultsManager.getBookmarkState(movieName: movieDetail.movieName ?? "")
        let newBookmarkState = !isCurrentlyBookmarked
        
        userDefaultsManager.setBookmarkState(movieName: movieDetail.movieName ?? "", isBookmarked: newBookmarkState)
        
        let imageName = newBookmarkState ? "bookmark.fill" : "bookmark"
        navigationItem.rightBarButtonItem?.image = UIImage(systemName: imageName)
        dataManager.fetchWatchList {
            self.viewModel.movieSelected = self.dataManager.watchList
        }
        if newBookmarkState {
            dataManager.saveWatchList(movieModel: movieDetail)
        } else {
            if let selectedMovie = viewModel.movieSelected.first(where: { $0.movieName == movieDetail.movieName }) {
                dataManager.deleteWatchList(movie: selectedMovie, completion: nil)
            } else {
                print("Movie not found in the watchlist.")
            }
        }
    }
}

extension MovieDetailVC: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.item == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(DetailCategoryCell.self)", for: indexPath) as! DetailCategoryCell
            cell.categorytapped = { category in
                self.viewModel.categorySelected = category
                self.collection.reloadData()
            }
            
            return cell
        }
        
        switch viewModel.categorySelected  {
        case "About Movie":
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(CategoryDetailCell.self)", for: indexPath) as! CategoryDetailCell
            cell.detailLabel(text: self.viewModel.movieDetail?.aboutMovie ?? "")
            
            return cell
        case "Watch Trailer":
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(CategoryDetailCell.self)", for: indexPath) as! CategoryDetailCell
            cell.loadVideo(videoID: viewModel.movieDetail?.trailer ?? "")
            
            return cell
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(CategoryDetailCell.self)", for: indexPath) as! CategoryDetailCell
            cell.detailLabel(text: self.viewModel.movieDetail?.aboutMovie ?? "")
            
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "MovieDetailReusableView", for: indexPath) as! MovieDetailReusableView
        header.setMovieDetail(background: viewModel.movieDetail?.backgroundImage ?? "",
                              poster: viewModel.movieDetail?.posterImage ?? "",
                              movieName: viewModel.movieDetail?.movieName ?? "",
                              releaseDate: viewModel.movieDetail?.releaseDate ?? "",
                              rating: String(viewModel.movieDetail?.rating ?? 0),
                              duration: viewModel.movieDetail?.time ?? "",
                              category: viewModel.movieDetail?.category ?? "")
        
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.item == 0 {
            return .init(width: collectionView.frame.width, height: 50)
        }
        return .init(width: collectionView.frame.width, height: 300)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        .init(width: collectionView.frame.width, height: 350)
    }
}
