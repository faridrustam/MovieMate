//
//  DetailCategoryCell.swift
//  MovieMate
//
//  Created by Farid Rustamov on 09.01.25.
//

import UIKit

class DetailCategoryCell: UICollectionViewCell {
    
    @IBOutlet private weak var collection: UICollectionView!
    
    var detailCategory: [MovieDetailCategory] = [.init(name: "About Movie", isSelected: true),
                                                 .init(name: "Watch Trailer", isSelected: false)]
    var categorytapped: ((String) -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        configureUI()
    }
    
    func configureUI() {
        collection.delegate = self
        collection.dataSource = self
        collection.backgroundColor = UIColor(named: "BackgroundColor")
        collection.register(UINib(nibName: "\(CategoryCell.self)", bundle: nil), forCellWithReuseIdentifier: "\(CategoryCell.self)")
    }
}

extension DetailCategoryCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        detailCategory.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(CategoryCell.self)", for: indexPath) as! CategoryCell
        cell.callElement(category: detailCategory[indexPath.item].name ?? "",
                         isSelected: detailCategory[indexPath.item].isSelected ?? false)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        for (index, _) in detailCategory.enumerated() {
            detailCategory[index].isSelected = (index == indexPath.item)
        }
        collectionView.reloadData()
        
        let selectedCategory = detailCategory[indexPath.item].name ?? ""
        categorytapped?(selectedCategory)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        .init(width: 130, height: collectionView.frame.height)
    }
}

