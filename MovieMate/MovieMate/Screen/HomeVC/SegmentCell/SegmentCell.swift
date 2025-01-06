//
//  SegmentCell.swift
//  MovieMate
//
//  Created by Farid Rustamov on 03.01.25.
//

import UIKit

class SegmentCell: UICollectionViewCell {

    @IBOutlet weak private var collection: UICollectionView!
    
    var category: [CategoryModel] = []
    var categoryTapped: ((CategoryModel) -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureUI()
    }
    
    func configureUI() {
        collection.delegate = self
        collection.dataSource = self
        
        collection.register(UINib(nibName: "CategoryCell", bundle: nil), forCellWithReuseIdentifier: "CategoryCell")
    }
    
    func configure(data: [CategoryModel]) {
        category = data
        collection.reloadData()
    }
}

extension SegmentCell: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        category.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCell", for: indexPath) as! CategoryCell
        cell.callElement(category: category[indexPath.item].categoryName ?? "")
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedCategory = category[indexPath.item]
        
        categoryTapped?(selectedCategory)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        .init(width: 80, height: collectionView.frame.height)
    }
    
    
}
