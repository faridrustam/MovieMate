//
//  MovieCell.swift
//  MovieMate
//
//  Created by Farid Rustamov on 02.01.25.
//

import UIKit

class MovieCell: UICollectionViewCell {
    
    @IBOutlet private weak var moviePoster: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        configureUI()
    }
    
    func configureUI() {
        moviePoster.layer.cornerRadius = moviePoster.frame.height / 8
        moviePoster.clipsToBounds = true
    }
    
    func callElement(movie: String) {
        moviePoster.image = UIImage(named: movie)
    }
    
}
