//
//  ViewController.swift
//  MovieMate
//
//  Created by Farid Rustamov on 01.01.25.
//

import UIKit

class HomeVC: UIViewController {

    @IBOutlet private var controllerView: UIView!
    @IBOutlet weak private var backgroundSearch: UIView!
    @IBOutlet weak private var searcTextField: UITextField!
    @IBOutlet weak private var collection: UICollectionView!
    
    let viewModel = HomeViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        viewModel.getMovieList()
    }
    
    func configureUI() {
        backgroundSearch.layer.cornerRadius = backgroundSearch.frame.height / 2
        
        backgroundSearch.backgroundColor = UIColor(named: "SearchBarColor")
        collection.backgroundColor = UIColor(named: "BackgroundColor")
        controllerView.backgroundColor = UIColor(named: "BackgroundColor")
        searcTextField.attributedPlaceholder = NSAttributedString(string: "Search", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
    }
}

extension HomeVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.movieList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCell", for: indexPath) as! MovieCell
        cell.callElement(movie: viewModel.movieList[indexPath.row].category?.image ?? "")
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let controller = storyboard?.instantiateViewController(identifier: "\(MovieDetailVC.self)") as! MovieDetailVC
        
        navigationController?.show(controller, sender: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        .init(width: 100, height: 145)
    }
}

