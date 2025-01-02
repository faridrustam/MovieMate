//
//  MovieSearchVC.swift
//  MovieMate
//
//  Created by Farid Rustamov on 02.01.25.
//

import UIKit

class MovieSearchVC: UIViewController {
    
    @IBOutlet var controllerView: UIView!
    @IBOutlet weak var backgroundSearch: UIView!
    @IBOutlet weak var searchTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    func configureUI() {
        backgroundSearch.layer.cornerRadius = backgroundSearch.frame.height / 2
        backgroundSearch.backgroundColor = UIColor(named: "SearchBarColor")
        searchTextField.attributedPlaceholder = NSAttributedString(string: "Search", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
    }
}
