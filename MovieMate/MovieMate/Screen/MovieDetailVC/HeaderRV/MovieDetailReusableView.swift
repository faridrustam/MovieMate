//
//  MovieDetailReusableView.swift
//  MovieMate
//
//  Created by Farid Rustamov on 06.01.25.
//

import UIKit

class MovieDetailReusableView: UICollectionReusableView {

    @IBOutlet weak var collection: UICollectionView!
    
    let detailCategory = ["About Movie", "Watch Trailer", "Similar Movies"]
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

extension MovieDetailReusableView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        detailCategory.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(CategoryCell.self)", for: indexPath) as! CategoryCell
        cell.callElement(category: detailCategory[indexPath.item])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedCategory = detailCategory[indexPath.item]
        categorytapped?(selectedCategory)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        .init(width: 130, height: collectionView.frame.height)
    }
}
