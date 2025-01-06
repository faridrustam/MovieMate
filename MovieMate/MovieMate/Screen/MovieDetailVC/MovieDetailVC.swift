//
//  MovieDetailVC.swift
//  MovieMate
//
//  Created by Farid Rustamov on 02.01.25.
//

import UIKit

class MovieDetailVC: UIViewController {

    @IBOutlet weak private var ratingBackgroundView: UIView!
    @IBOutlet private var backgroundView: UIView!
    @IBOutlet weak private var posterImage: UIImageView!
    @IBOutlet weak private var backgroundMovieImage: UIImageView!
    @IBOutlet weak private var movieNameLabel: UILabel!
    @IBOutlet weak private var yearLabel: UILabel!
    @IBOutlet weak private var durationLabel: UILabel!
    @IBOutlet weak private var categoryLabel: UILabel!
    @IBOutlet weak private var ratingLabel: UILabel!
    @IBOutlet weak private var collection: UICollectionView!
    
    var movieDetail: MovieModel?
    var movies: [MovieModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        setMovieDetail()
    }
    
    func configureUI() {
        collection.delegate = self
        collection.dataSource = self
        navigationItem.title = "Detail"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        
        ratingBackgroundView.layer.cornerRadius = ratingBackgroundView.frame.height / 6
        ratingBackgroundView.layer.masksToBounds = true
        posterImage.layer.cornerRadius = posterImage.frame.height / 6
        posterImage.layer.masksToBounds = true
        backgroundView.backgroundColor = UIColor(named: "BackgroundColor")
        collection.backgroundColor = UIColor(named: "BackgroundColor")
        
        collection.register(UINib(nibName: "\(MovieDetailReusableView.self)", bundle: nil),
                            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                            withReuseIdentifier: "\(MovieDetailReusableView.self)")
        
        collection.register(UINib(nibName: "MovieCell", bundle: nil),
                            forCellWithReuseIdentifier: "MovieCell")
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "bookmark"),
                                                            style: .plain, target: nil, action: #selector (bookmarkButtonTapped))

    }
    
    func setMovieDetail() {
        backgroundMovieImage.image = UIImage(named: movieDetail?.bacgroundImage ?? "")
        posterImage.image = UIImage(named: movieDetail?.posterImage ?? "")
        movieNameLabel.text = movieDetail?.movieName
        yearLabel.text = movieDetail?.releaseDate
        ratingLabel.text = String(movieDetail?.rating ?? 0)
        durationLabel.text = movieDetail?.time
        categoryLabel.text = movieDetail?.categoryId
    }
    
    @objc func bookmarkButtonTapped() {
        
    }
    
    func configure(data: [MovieModel]) {
        movies = data
        collection.reloadData()
    }
}

extension MovieDetailVC: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(MovieCell.self)", for: indexPath) as! MovieCell
        cell.callElement(movie: movies[indexPath.item].posterImage ?? "")
        print(movies)
        
        return cell
    }
    
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        <#code#>
//    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        .init(width: collectionView.frame.width, height: 300)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "MovieDetailReusableView", for: indexPath) as! MovieDetailReusableView
        header.categorytapped = { [weak self] category in
                // kateqoriyalara uyğun cell-lər gələcək
        }
        
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        .init(width: collectionView.frame.width, height: 50)
    }
}
