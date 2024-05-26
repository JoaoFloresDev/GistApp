//
//  GistCell.swift
//  GistList
//
//  Created by Joao Victor Flores da Costa on 26/05/24.
//

import UIKit
import SnapKit

class GistCell: UITableViewCell {
    // MARK: - Views
    private lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = Spaces.base02.value()
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.1
        view.layer.shadowOffset = CGSize(width: .zero, height: 1)
        view.layer.shadowRadius = 4
        return view
    }()
    
    private lazy var nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.font = UIFont.preferredFont(forTextStyle: .headline)
        nameLabel.numberOfLines = 0
        return nameLabel
    }()
    
    private lazy var filesLabel: UILabel = {
        let filesLabel = UILabel()
        filesLabel.font = .preferredFont(forTextStyle: .body)
        filesLabel.numberOfLines = 0
        return filesLabel
    }()
    
    private lazy var avatarImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleToFill
        view.layer.cornerRadius = Spaces.base03.value()
        view.clipsToBounds = true
        view.backgroundColor = .lightGray
        return view
    }()
    
    // MARK: - Initialization
    init(model: GistCellModel) {
        super.init(style: .default, reuseIdentifier: "\(type(of: self))")
        configure(with: model)
        setupViewHierarchy()
        setupConstraints()
        setupAccessibility()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        avatarImageView.image = nil
        nameLabel.text = nil
        filesLabel.text = nil
    }
    
    // MARK: - Private Functions
    private func setupViewHierarchy() {
        contentView.addSubview(containerView)
        containerView.addSubview(nameLabel)
        containerView.addSubview(filesLabel)
        containerView.addSubview(avatarImageView)
    }
    
    private func setupConstraints() {
        containerView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(Spaces.base01.value())
            $0.top.bottom.equalToSuperview().inset(Spaces.base00.value())
        }
        
        avatarImageView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(Spaces.base02.value())
            $0.top.equalToSuperview().offset(Spaces.base01.value())
            $0.width.height.equalTo(Spaces.base06.value())
        }
        
        nameLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(Spaces.base01.value())
            $0.leading.equalTo(avatarImageView.snp.trailing).offset(Spaces.base02.value())
            $0.trailing.equalToSuperview().inset(Spaces.base02.value())
        }
        
        filesLabel.snp.makeConstraints {
            $0.top.equalTo(nameLabel.snp.bottom).offset(Spaces.base01.value())
            $0.leading.equalTo(avatarImageView.snp.trailing).offset(Spaces.base02.value())
            $0.trailing.equalToSuperview().inset(Spaces.base02.value())
            $0.bottom.equalToSuperview().inset(Spaces.base01.value())
        }
    }
    
    private func configure(with model: GistCellModel) {
        nameLabel.text = model.userName
        filesLabel.text = model.filesAmount
        avatarImageView.fetchImage(from: model.userImageUrl)
    }
    
    private func setupAccessibility() {
        isAccessibilityElement = true
        accessibilityLabel = "Gist Cell"
        accessibilityValue = "User: \(nameLabel.text ?? "Unknown"), \(filesLabel.text ?? "Unknown")"
    }
}
