//
//  MovieSearchVC.swift
//  MovieMate
//
//  Created by Farid Rustamov on 02.01.25.
//

import UIKit

class MovieSearchVC: UIViewController {
    
    @IBOutlet private var controllerView: UIView!
    @IBOutlet weak private var backgroundSearch: UIView!
    @IBOutlet weak private var searchTextField: UITextField!
    @IBOutlet weak private var collection: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    func configureUI() {
        backgroundSearch.layer.cornerRadius = backgroundSearch.frame.height / 2
        backgroundSearch.backgroundColor = UIColor(named: "SearchBarColor")
        searchTextField.attributedPlaceholder = NSAttributedString(string: "Search", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        controllerView.backgroundColor = UIColor(named: "BackgroundColor")
        collection.backgroundColor = UIColor(named: "BackgroundColor")
    }
}
