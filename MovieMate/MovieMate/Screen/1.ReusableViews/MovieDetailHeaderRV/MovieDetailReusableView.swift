//
//  MovieDetailReusableView.swift
//  MovieMate
//
//  Created by Farid Rustamov on 06.01.25.
//

import UIKit

class MovieDetailReusableView: UICollectionReusableView {
    
    @IBOutlet private weak var backgroundImage: UIImageView!
    @IBOutlet private weak var posterImage: UIImageView!
    @IBOutlet private weak var movieNameLabel: UILabel!
    @IBOutlet private weak var yearLabel: UILabel!
    @IBOutlet private weak var durationLabel: UILabel!
    @IBOutlet private weak var categoryLabel: UILabel!
    @IBOutlet private weak var ratingLabel: UILabel!
    @IBOutlet private weak var ratingBackgroundView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureUI()
    }
    
    func configureUI() {
        movieNameLabel.numberOfLines = 0
        ratingBackgroundView.layer.cornerRadius = ratingBackgroundView.frame.height / 6
        ratingBackgroundView.layer.masksToBounds = true
        posterImage.layer.cornerRadius = posterImage.frame.height / 6
        posterImage.layer.masksToBounds = true
    }
    
    func setMovieDetail(background: String, poster: String, movieName: String, releaseDate: String, rating: String, duration: String, category: String) {
        backgroundImage.image = UIImage(named: background)
        posterImage.image = UIImage(named: poster)
        movieNameLabel.text = movieName
        yearLabel.text = releaseDate
        ratingLabel.text = rating
        durationLabel.text = duration
        categoryLabel.text = category
    }
}
