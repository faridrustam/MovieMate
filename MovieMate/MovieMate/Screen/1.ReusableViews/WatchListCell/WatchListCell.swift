//
//  WatchListCell.swift
//  MovieMate
//
//  Created by Farid Rustamov on 03.01.25.
//

import UIKit

class WatchListCell: UITableViewCell {
    
    @IBOutlet private weak var poster: UIImageView!
    @IBOutlet private weak var movieName: UILabel!
    @IBOutlet private weak var ratingLabel: UILabel!
    @IBOutlet private weak var categoryLabel: UILabel!
    @IBOutlet private weak var yearLabel: UILabel!
    @IBOutlet private weak var durationLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureUI()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configureUI() {
        movieName.numberOfLines = 0
        poster.layer.cornerRadius = poster.frame.height / 6
        poster.clipsToBounds = true
    }
    
    func callElement(posterImage: String, movie: String, rating: Double, category: String, year: String, duration: String) {
        poster.image = UIImage(named: posterImage)
        movieName.text = movie
        ratingLabel.text = "\(rating)"
        categoryLabel.text = category
        yearLabel.text = year
        durationLabel.text = duration
    }
}
