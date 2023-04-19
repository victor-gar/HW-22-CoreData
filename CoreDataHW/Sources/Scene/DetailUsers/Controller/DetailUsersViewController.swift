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
    private var isPushButton = false
    private var gender: String?
    private var imageData: Data?
    
    // MARK: - View

    private var deatilView: DetailUsersView? {
        guard isViewLoaded
        else { return nil }
        return view as? DetailUsersView
    }
    private lazy var editButton = UIBarButtonItem(title: "Edit",
                                                  style: .done,
                                                  target: self,
                                                  action: #selector(editButtonAction))
        
    //MARK: - Lifecycle
    
    override func loadView() {
        view = DetailUsersView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationController()
        presenter?.getUser()
        setupView()
        setupActions()
    }
}

extension DetailUsersViewController {
    
    func setupNavigationController() {
        navigationController?.navigationBar.tintColor = .black
        navigationItem.rightBarButtonItem = editButton
    }
    
    func setupView() {
        [deatilView?.userNameTextField ,
         deatilView?.datePicker,
         deatilView?.genderControl].forEach {
            $0?.isEnabled = isPushButton
        }
        deatilView?.isUserInteractionEnabled = isPushButton
    }
    
    func setupActions() {
        deatilView?.genderControl.addTarget(nil, action: #selector(segmentDidChange(_:)), for: .valueChanged)
        let tap = UITapGestureRecognizer(target: self, action: #selector(chooseAvatar))
        deatilView?.photoImageView.addGestureRecognizer(tap)
    }
}

// MARK: - UserInfoViewProtocol

extension DetailUsersViewController: DetailUserInfoViewProtocol {
    
    func displayUser(userName: String?,
                     birthday: Date?,
                     gender: String?,
                     avatar: Data?) {
        deatilView?.userNameTextField.text = userName
        if avatar == nil {
            deatilView?.photoImageView.image = UIImage(named: "image")
        } else {
            deatilView?.photoImageView.image = UIImage(data: avatar!) }
        deatilView?.datePicker.date = birthday ?? .now
        switch gender {
        case "Мужской":
            deatilView?.genderControl.selectedSegmentIndex = 0
        case "Женский":
            deatilView?.genderControl.selectedSegmentIndex = 1
        default:
            break
        }
    }
}

// MARK: - Action

extension DetailUsersViewController {
    
    @objc
    private func segmentDidChange(_ sender: UISegmentedControl) {
        if deatilView?.genderControl.selectedSegmentIndex == 0 {
            gender = "Мужской"
        } else {
            gender = "Женский"
        }
    }
    
    @objc
    func chooseAvatar(sender: UITapGestureRecognizer) {
        let galleryAction = UIAlertAction(title: Strings.alertTitleGallery,
                                          style: .default,
                                          handler: addFromGallery)
        let photoAction = UIAlertAction(title: Strings.alertTitlePhoto,
                                        style: .default,
                                        handler: doNewPhoto)
        showActionSheet(actions: [galleryAction,
                                  photoAction,])
    }
    
    @objc
    private func editButtonAction() {
        isPushButton.toggle()
        setupView()
        switch isPushButton {
        case true:
            editButton.title = "Save"
            editButton.tintColor = .systemRed
        case false:
            editButton.title = "Edit"
            editButton.tintColor = .black
            let userName = deatilView?.userNameTextField.text
            let birthday = deatilView?.datePicker.date
            presenter?.saveUser(userName: userName,
                                birthday: birthday,
                                gender: gender,
                                avatar: imageData)
        }
    }
}

// MARK: - UIImagePickerControllerDelegate

extension DetailUsersViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage
        else {
            fatalError("\(Strings.error)\(info)")
        }
        imageData = image.pngData() as Data?
        deatilView?.photoImageView.image = image
        deatilView?.photoImageView.contentMode = .scaleAspectFill
        deatilView?.photoImageView.clipsToBounds = true
        picker.dismiss(animated: true, completion: nil)
    }
    
    func addFromGallery(action: UIAlertAction) {
        deatilView?.photoLibraryPicker.delegate = self
        guard let picker = deatilView?.photoLibraryPicker
        else {
            return }
        present(picker, animated: true, completion: nil)
    }
    
    func doNewPhoto(action: UIAlertAction) {
        deatilView?.photoCameraPicker.delegate = self
        guard let picker = deatilView?.photoCameraPicker
        else {
            return }
        present(picker, animated: true, completion: nil)
    }
}

// MARK: - Constants

extension DetailUsersViewController {
    
    enum Strings {
        static let navigationButtonSave: String = "Save"
        static let navigationButtonEdit: String = "Edit"
        static let alertTitleGallery: String = "Choose from gallery"
        static let alertTitlePhoto: String = "Take photo"
        static let error: String = "Expected a dictionary containing an image, but was provided the following: "
    }
}





