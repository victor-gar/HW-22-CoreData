//
//  ViewController.swift
//  CoreData
//
//  Created by Victor Garitskyu on 17.04.2023.
//

import UIKit

class UsersViewController: UIViewController {
    
    //MARK: - Properties
    
    var presenter: UsersPresenterProtocol?
    
    // MARK: - View

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

// MARK: - UsersViewProtocol

extension UsersViewController: UsersViewProtocol {
    
    func reload() {
        presenter?.updateUsers()
        usersView?.tableView.reloadData()
    }
}

// MARK: - Actions

extension UsersViewController {
    
    @objc
    func saveUser() {
        let userName: String = usersView?.textField.text ?? ""
        presenter?.saveFullName(name: userName)
        usersView?.textField.text = nil
    }
}

// MARK: - Constants

extension UsersViewController {
    
    enum Strings {
        static let navigationTitle: String = "Users"
        static let delete: String = "Delete"
    }
}

