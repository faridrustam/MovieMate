//
//  MovieCell.swift
//  MovieMate
//
//  Created by Farid Rustamov on 02.01.25.
//

import UIKit

class MovieCell: UICollectionViewCell {

    @IBOutlet weak private var moviePoster: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func callElement(movie: String) {
        moviePoster.image = UIImage(named: movie)
    }

}
