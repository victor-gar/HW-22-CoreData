//
//  UsersView.swift
//  CoreData
//
//  Created by Victor Garitskyu on 18.04.2023.
//

import UIKit
import SnapKit

class UsersView: UIView {
    
    //MARK: - UI Elements
    
    lazy var textField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Press your name here"
        textField.font = UIFont.systemFont(ofSize: 16)
        textField.textAlignment = .left
        textField.textColor = .black
        textField.backgroundColor = .systemGray5
        textField.borderStyle = .roundedRect
        textField.isUserInteractionEnabled = true
        return textField
    }()
    
    lazy var newUserButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Press", for: .normal)
        button.backgroundColor = .systemBlue
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        button.tintColor = .white
        button.layer.cornerRadius = 6
        return button
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView.init(frame: CGRect.zero, style: .insetGrouped)
        tableView.backgroundColor = .systemGray5
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
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
        addSubview(newUserButton)
        addSubview(tableView)
        addSubview(textField)
    }
    
    private func setupLayout() {
        textField.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(12)
            make.top.equalToSuperview().inset(150)
            make.height.equalTo(38)
        }
        
        newUserButton.snp.makeConstraints { make in
            make.left.right.equalTo(textField)
            make.top.equalTo(textField.snp.bottom).inset(-20)
            make.height.equalTo(38)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(newUserButton.snp.bottom).inset(-20)
            make.right.left.bottom.equalToSuperview()
        }
    }
}
