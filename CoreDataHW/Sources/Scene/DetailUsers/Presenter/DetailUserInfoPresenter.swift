//
//  DetailUserInfoPresenter.swift
//  CoreDataHW
//
//  Created by Victor Garitskyu on 19.04.2023.
//

import Foundation


import Foundation
// MARK: - DetailUserInfoViewProtocol

protocol DetailUserInfoViewProtocol: AnyObject {
    func displayUser(userName: String?,
                     birthday: Date?,
                     gender: String?,
                     avatar: Data?)
}

// MARK: - DetailUsersPresenterProtocol

protocol DetailUserInfoPresenterProtocol: AnyObject {
    init(view: DetailUserInfoViewProtocol,
         router: RouterProtocol,
         userName: String)
    var user: UserInfo? { get set }
    func saveUser(userName: String?,
                  birthday: Date?,
                  gender: String?,
                  avatar: Data?)
    func getUser()
}

// MARK: - UsersPresenter

class DetailUserInfoPresenter: DetailUserInfoPresenterProtocol {
    // MARK: - Properties
    
    let view: DetailUserInfoViewProtocol?
    var router: RouterProtocol?
    let userName: String
    var user: UserInfo?
    
    // MARK: - Initialization
    
    required init(view: DetailUserInfoViewProtocol,
                  router: RouterProtocol,
                  userName: String) {
        self.view = view
        self.router = router
        self.userName = userName
        fetchUser(userName: userName)
    }
    
    // MARK: - Methods
    
    private func fetchUser(userName: String) {
        guard let users = AppDelegate.sharedAppDelegate.persistenceStack.fetchUser()
        else {
            return }
        for user in users where user.fullName == self.userName {
            self.user = user
        }
    }
    
    func getUser() {
        let userName = user?.value(forKeyPath: CoreDataKeyPath.userFullName.rawValue) as? String
        let birthday = user?.value(forKeyPath: CoreDataKeyPath.birthday.rawValue) as? Date
        let gender = user?.value(forKeyPath: CoreDataKeyPath.gender.rawValue) as? String
        let avatar = user?.value(forKeyPath: CoreDataKeyPath.avatarImage.rawValue) as? Data
        self.view?.displayUser(userName: userName,
                               birthday: birthday,
                               gender: gender,
                               avatar: avatar)
    }
    
    func saveUser(userName: String?,
                  birthday: Date?,
                  gender: String?,
                  avatar: Data?) {
        user?.fullName = userName
        user?.birthday = birthday
        user?.gender = gender
        user?.avatarImage = avatar
        guard let user = user else { return }
        AppDelegate.sharedAppDelegate.persistenceStack.updateProfile(user: user)
    }
}
