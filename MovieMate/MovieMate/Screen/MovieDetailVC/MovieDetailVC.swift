//
//  MovieDetailVC.swift
//  MovieMate
//
//  Created by Farid Rustamov on 02.01.25.
//

import UIKit

class MovieDetailVC: UIViewController {
    
    @IBOutlet private var backgroundView: UIView!
    @IBOutlet weak private var collection: UICollectionView!
    
    var movieDetail: MovieModel?
    var categorySelected: String?
    let dataManager = WatchListCoreData()
    var success: (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
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
    
    @objc func bookmarkButtonTapped() {
        dataManager.saveWatchList(movieModel: movieDetail!)
        if let currentImage = navigationItem.rightBarButtonItem?.image {
            if currentImage == UIImage(systemName: "bookmark") {
                navigationItem.rightBarButtonItem?.image = UIImage(systemName: "bookmark.fill")
            } else {
                navigationItem.rightBarButtonItem?.image = UIImage(systemName: "bookmark")
            }
            //success?()
            NotificationCenter.default.post(name: Notification.Name("WatchListUpdated"), object: nil)
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
                self.categorySelected = category
                self.collection.reloadData()
            }
            
            return cell
        }
        
        switch categorySelected  {
        case "About Movie":
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(CategoryDetailCell.self)", for: indexPath) as! CategoryDetailCell
            cell.detailLabel(text: self.movieDetail?.aboutMovie ?? "")
            
            return cell
        case "Watch Trailer":
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(CategoryDetailCell.self)", for: indexPath) as! CategoryDetailCell
            cell.loadVideo(videoID: movieDetail?.trailer ?? "")
            
            return cell
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(CategoryDetailCell.self)", for: indexPath) as! CategoryDetailCell
            cell.detailLabel(text: self.movieDetail?.aboutMovie ?? "")
            
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "MovieDetailReusableView", for: indexPath) as! MovieDetailReusableView
        header.setMovieDetail(background: movieDetail?.backgroundImage ?? "",
                              poster: movieDetail?.posterImage ?? "",
                              movieName: movieDetail?.movieName ?? "",
                              releaseDate: movieDetail?.releaseDate ?? "",
                              rating: String(movieDetail?.rating ?? 0),
                              duration: movieDetail?.time ?? "",
                              category: movieDetail?.category ?? "")

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
