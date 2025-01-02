//
//  CategoryCell.swift
//  MovieMate
//
//  Created by Farid Rustamov on 02.01.25.
//

import UIKit

class CategoryCell: UICollectionViewCell {

    @IBOutlet weak private var categoryLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        categoryLabel.textColor = .white
    }

    func callElement(genre: String) {
        categoryLabel.text = genre
    }
}
