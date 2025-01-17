//
//  HeaderReusableView.swift
//  MovieMate
//
//  Created by Farid Rustamov on 02.01.25.
//

import UIKit

class HeaderReusableView: UICollectionReusableView {
    
    @IBOutlet private weak var collection: UICollectionView!
    
    var movies: [MovieModel] = []
    var filteredRating: [MovieModel] = []
    var movieTapped: ((MovieModel) -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        configureUI()
    }
    
    func configureUI() {
        collection.delegate = self
        collection.dataSource = self
        collection.backgroundColor = UIColor(named: "Background")
        
        collection.register(UINib(nibName: "\(MovieCell.self)", bundle: nil), forCellWithReuseIdentifier: "\(MovieCell.self)")
    }
    
    func filterRating() {
        filteredRating = movies.filter {
            ($0.rating ?? 0) >= Double(8.0)
        }
    }
    
    func configure(data: [MovieModel]) {
        movies = data
        filterRating()
        collection.reloadData()
    }
}

extension HeaderReusableView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        filteredRating.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCell", for: indexPath) as! MovieCell
        cell.callElement(movie: filteredRating[indexPath.item].posterImage ?? "")
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedMovie = movies[indexPath.item]
        movieTapped?(selectedMovie)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        .init(width: 145, height: 230)
    }
}
