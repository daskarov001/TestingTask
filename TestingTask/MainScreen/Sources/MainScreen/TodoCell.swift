//
//  TodoCell.swift
//  MainScreen
//
//  Created by Asqarov Diyorjon on 03/03/25.
//


import UIKit
import SnapKit
import Module

class TodoCell: UITableViewCell {
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.numberOfLines = 0 // Allow multiple lines
        return label
    }()
    
    private let userLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = .darkGray
        label.numberOfLines = 0 // Allow multiple lines
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        self.selectionStyle = .none
        contentView.addSubview(titleLabel)
        contentView.addSubview(userLabel)
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.leading.trailing.equalToSuperview().inset(16)
        }
        
        userLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(5)
            make.leading.trailing.equalToSuperview().inset(16)
            make.bottom.equalToSuperview().offset(-10) 
        }
    }
    
    func configure(with todoWithUser: TodoWithUser) {
        titleLabel.text = todoWithUser.todo.title
        userLabel.text = todoWithUser.user?.username ?? "Unknown User"
    }
}
