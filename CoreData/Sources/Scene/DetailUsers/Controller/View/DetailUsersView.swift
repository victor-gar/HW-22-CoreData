//
//  DetailUsersView.swift
//  CoreData
//
//  Created by Victor Garitskyu on 18.04.2023.
//

import UIKit

class DetailUsersView: UIView {
    
    //MARK: - UI Elements
    
    private lazy var photoImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "image"))
        imageView.layer.cornerRadius = 30
        imageView.layer.masksToBounds = true
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.isUserInteractionEnabled = true
        imageView.tintColor = .secondarySystemBackground
        return imageView
    }()
    
    private lazy var avatarIcon: UIImageView = {
        let icon = UIImage(systemName: "person")
        let imageView = UIImageView(image: icon)
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .lightGray
        imageView.preferredSymbolConfiguration = UIImage.SymbolConfiguration(pointSize: 36, weight: .regular)
        return imageView
    }()
    
    private lazy var calendarIcon: UIImageView = {
        let icon = UIImage(systemName: "calendar")
        let imageView = UIImageView(image: icon)
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .lightGray
        imageView.preferredSymbolConfiguration = UIImage.SymbolConfiguration(pointSize: 36, weight: .regular)
        return imageView
    }()
    
    private lazy var genderIcon: UIImageView = {
        let icon = UIImage(systemName: "face.smiling")
        let imageView = UIImageView(image: icon)
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .lightGray
        imageView.preferredSymbolConfiguration = UIImage.SymbolConfiguration(pointSize: 36, weight: .regular)
        return imageView
    }()
    
    private lazy var separatorViewFirst = createSeparatorViewLine()
    private lazy var separatorViewSecond = createSeparatorViewLine()
    private lazy var separatorViewThird = createSeparatorViewLine()

    private lazy var datePicker: UIDatePicker = {
        var datePicker = UIDatePicker()
        datePicker.preferredDatePickerStyle = .compact
        datePicker.maximumDate = Date.now
        datePicker.datePickerMode = .date
//        datePicker.isEnabled = false
        return datePicker
    }()
    
    private lazy var userNameTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.tintColor = .gray
        textField.backgroundColor = .systemGray6
        return textField
    }()
    
    lazy var genderControl: UISegmentedControl = {
        let segmentedItems = ["Мужской", "Женский"]
        let font = UIFont.systemFont(ofSize: 16)
        let segmentedControl = UISegmentedControl(items: segmentedItems)
        let selectedAttribute: [NSAttributedString.Key: Any] = [.font: font, .foregroundColor: UIColor.black]
        let normalAttribute: [NSAttributedString.Key: Any] = [.font: font, .foregroundColor: UIColor.lightGray]
        segmentedControl.setTitleTextAttributes(selectedAttribute, for: .selected)
        segmentedControl.setTitleTextAttributes(normalAttribute, for: .normal)
        segmentedControl.selectedSegmentIndex = 0
//        segmentedControl.isEnabled = false
        return segmentedControl
    }()
    

    //MARK: - Lifecycle
    
    init() {
        super.init(frame: .zero)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        backgroundColor = .white
        setupHierarchy()
        setupLayout()
    }
    //MARK: - Setups
    
    private func setupHierarchy() {
        addSubview(photoImageView)
        addSubview(avatarIcon)
        addSubview(calendarIcon)
        addSubview(genderIcon)
        addSubview(separatorViewFirst)
        addSubview(separatorViewSecond)
        addSubview(separatorViewThird)
        addSubview(datePicker)
        addSubview(genderControl)
        addSubview(userNameTextField)
    }

    
    private func setupLayout() {
        photoImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(100)
            make.height.width.equalTo(180)
        }
        avatarIcon.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(30)
            make.top.equalTo(photoImageView.snp.bottom).inset(-30)
        }
        
        userNameTextField.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(20)
            make.leading.equalTo(avatarIcon.snp.trailing).inset(-20)
            make.top.equalTo(photoImageView.snp.bottom).inset(-30)
        }
        
        calendarIcon.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(30)
            make.top.equalTo(avatarIcon.snp.bottom).inset(-20)
        }
        
        datePicker.snp.makeConstraints { make in
            make.leading.equalTo(calendarIcon.snp.trailing).inset(-20)
            make.top.equalTo(avatarIcon.snp.bottom).inset(-20)
        }
        
        genderIcon.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(30)
            make.top.equalTo(calendarIcon.snp.bottom).inset(-20)
        }
        
        genderControl.snp.makeConstraints { make in
            make.leading.equalTo(genderIcon.snp.trailing).inset(-20)
            make.top.equalTo(calendarIcon.snp.bottom).inset(-20)
        }
        
        separatorViewFirst.snp.makeConstraints { make in
            make.top.equalTo(avatarIcon.snp.bottom).inset(-10)
            make.trailing.leading.equalToSuperview().inset(20)
            make.height.equalTo(1)

        }
        
        separatorViewSecond.snp.makeConstraints { make in
            make.top.equalTo(calendarIcon.snp.bottom).inset(-10)
            make.trailing.leading.equalToSuperview().inset(20)
            make.height.equalTo(1)
        }
        
        separatorViewThird.snp.makeConstraints { make in
            make.top.equalTo(genderIcon.snp.bottom).inset(-10)
            make.trailing.leading.equalToSuperview().inset(20)
            make.height.equalTo(1)
        }
    }
}

extension UIView {
    
    func createSeparatorViewLine() -> UIView {
        let view = UIView()
        view.backgroundColor = .systemGray4
        return view
    }
}
