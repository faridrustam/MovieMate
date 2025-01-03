//
//  HeaderReusableView.swift
//  MovieMate
//
//  Created by Farid Rustamov on 02.01.25.
//

import UIKit

class HeaderReusableView: UICollectionReusableView {

    @IBOutlet weak var collection: UICollectionView!

    var movies: [MovieModel] = []
    
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
    
    func configure(data: [MovieModel]) {
        movies = data
        collection.reloadData()
    }
}

extension HeaderReusableView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCell", for: indexPath) as! MovieCell
        cell.callElement(movie: movies[indexPath.item].posterImage ?? "")
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        .init(width: 145, height: 210)
    }
}
