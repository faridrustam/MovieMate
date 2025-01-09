//
//  CategoryDetailCell.swift
//  MovieMate
//
//  Created by Farid Rustamov on 07.01.25.
//

import UIKit
import YouTubeiOSPlayerHelper

class CategoryDetailCell: UICollectionViewCell {

    @IBOutlet weak private var movieDetailLabel: UILabel!
    
    @IBOutlet weak var trailer: YTPlayerView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureUI()
    }
    
    func configureUI() {
        movieDetailLabel.isHidden = true
        trailer.isHidden = true

                
    }
    
    func detailLabel(text: String) {
        movieDetailLabel.isHidden = false
        trailer.isHidden = true
        movieDetailLabel.text = text
    }
    
    func loadVideo(videoID: String) {
        trailer.isHidden = false
        movieDetailLabel.isHidden = true
        trailer.load(withVideoId: videoID)
        }
}
