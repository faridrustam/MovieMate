//
//  CategoryCell.swift
//  MovieMate
//
//  Created by Farid Rustamov on 02.01.25.
//

import UIKit

class CategoryCell: UICollectionViewCell {
    
    @IBOutlet private weak var categoryLabel: UILabel!
    @IBOutlet private weak var underlineView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        configureUI()
    }
    
    func configureUI() {
        categoryLabel.textColor = .white
        underlineView.backgroundColor = .clear
    }
    
    func configure(data: CategoryModel) {
        categoryLabel.text = data.categoryName
        
        if let selection = data.isSelected {
            underlineView.backgroundColor = selection ? UIColor(named: "TabBarSelected") : .red
            underlineView.isHidden = !selection
        }
    }
    
    func callElement(category: String, isSelected: Bool) {
        categoryLabel.text = category
        
        underlineView.backgroundColor = isSelected ? UIColor(named: "TabBarSelected") : .clear
        underlineView.isHidden = !isSelected
    }
}
