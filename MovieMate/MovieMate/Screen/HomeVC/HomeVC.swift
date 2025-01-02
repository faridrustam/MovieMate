//
//  ViewController.swift
//  MovieMate
//
//  Created by Farid Rustamov on 01.01.25.
//

import UIKit

class HomeVC: UIViewController {
    
    @IBOutlet private var controllerView: UIView!
    @IBOutlet weak private var collection: UICollectionView!
    
    let viewModel = HomeViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        viewModel.getMovieList()
    }
    
    func configureUI() {
        collection.delegate = self
        collection.dataSource = self
        
        collection.backgroundColor = UIColor(named: "BackgroundColor")
        controllerView.backgroundColor = UIColor(named: "BackgroundColor")
        
        collection.register(UINib(nibName: "MovieCell", bundle: nil),
                            forCellWithReuseIdentifier: "MovieCell")
        collection.register(UINib(nibName: "HeaderReusableView", bundle: nil),
                            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                            withReuseIdentifier: "HeaderReusableView")
    }
}

extension HomeVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.movieList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(MovieCell.self)", for: indexPath) as! MovieCell
        cell.callElement(movie: viewModel.movieList[indexPath.item].posterImage ?? "")
        
        return cell
    }
    
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let controller = storyboard?.instantiateViewController(identifier: "\(MovieDetailVC.self)") as! MovieDetailVC
//        
//        navigationController?.show(controller, sender: nil)
//    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        .init(width: 100, height: 145)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {

        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "HeaderReusableView", for: indexPath) as! HeaderReusableView
        header.configure(data: viewModel.movieList)
        
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        .init(width: 393, height: 250)
    }
}
