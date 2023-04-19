//
//  ViewController.swift
//  CoreData
//
//  Created by Victor Garitskyu on 17.04.2023.
//

import UIKit

class UsersViewController: UIViewController {
    
    //MARK: - Properties

    private var usersView: UsersView? {
        guard isViewLoaded
        else {
            return nil }
        return view as? UsersView
    }
        
    //MARK: - Lifecycle
    
    override func loadView() {
        view = UsersView()
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
        navigationItem.title = "Users"
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    //MARK: - Setups


}

