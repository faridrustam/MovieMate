//
//  CategoryCell.swift
//  MovieMate
//
//  Created by Farid Rustamov on 02.01.25.
//

import UIKit

class CategoryCell: UICollectionViewCell {

    @IBOutlet weak private var categoryLabel: UILabel!
    @IBOutlet weak var underlineView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        categoryLabel.textColor = .white
    }

    func callElement(category: String, isSelected: Bool = true) {
        categoryLabel.text = category
        
        if isSelected {
            underlineView.backgroundColor = .white
        } else {
            underlineView.backgroundColor = .clear
        }
    }
}
