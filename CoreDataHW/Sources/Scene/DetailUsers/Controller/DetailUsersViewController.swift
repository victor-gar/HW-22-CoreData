//
//  DetailUsersViewController.swift
//  CoreData
//
//  Created by Victor Garitskyu on 18.04.2023.
//

import Foundation

import UIKit

class DetailUsersViewController: UIViewController {
    
    //MARK: - Properties
    var presenter: DetailUserInfoPresenterProtocol?

    // MARK: - View

    private var deatilView: DetailUsersView? {
        guard isViewLoaded
        else {
            return nil }
        return view as? DetailUsersView
    }
        
    //MARK: - Lifecycle
    
    override func loadView() {
        view = DetailUsersView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    //MARK: - Setups


}

// MARK: - DetailUserInfoViewProtocol





